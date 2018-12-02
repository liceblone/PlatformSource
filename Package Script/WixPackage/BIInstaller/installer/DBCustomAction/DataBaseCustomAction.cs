using System;
using System.Collections.Generic;
using System.Text;
using Microsoft.Deployment.WindowsInstaller; 
using System.Windows.Forms;
using CustomAction.Utilities;
using System.Data.SqlClient;
using System.Reflection;
using System.IO;
using System.Transactions;

namespace CustomAction
{
    public class DataBaseCustomAction
    {
        #region Fields
        private static SqlConnection m_sqlConectionMain = new SqlConnection();
        #endregion Fields

        #region Custom actions
        [CustomAction]
        public static ActionResult ExecuteSQLScripts(Session session)
        {
            try
            {
                MessageResult iResult;
                string sInstallLocation, sServidor, sBaseDatos, sMensaje;
                int iTotalTicks, iTickIncrement = 1;
                bool isCustomActionData = true;

                if (session == null)
                {
                    throw new ArgumentNullException("session");
                }

                sInstallLocation = GetSessionProperty(session, "INSTALLLOCATION", isCustomActionData);
                sServidor = GetSessionProperty(session, "DATABASE_SERVERNAME", isCustomActionData);
                sBaseDatos = GetSessionProperty(session, "DATABASE_NAME", isCustomActionData);
                List<DataBasePathTO> listPaths = GetCustomTableDataBasePaths(session, isCustomActionData);
                List<FeactureInstallTO> listF = session.CustomActionData.GetObject<List<FeactureInstallTO>>("DATABASE_FEACTURESCRIPTS");
                iTotalTicks = listF.Count;

                InstallUtilities.WriteLogInstall(session, "Starting ExecuteSQLScripts ...", null, true);
                iResult = InstallProgress.ResetProgress(session, iTotalTicks);
                if (iResult == MessageResult.Cancel)
                {
                    return ActionResult.UserExit;
                }

                sMensaje = "SQL Server: " + sServidor;
                iResult = InstallProgress.DisplayStatusActionStart(session, sMensaje, sMensaje, "[1] / [2]: [3]");
                if (iResult == MessageResult.Cancel)
                {
                    return ActionResult.UserExit;
                }

                iResult = InstallProgress.NumberOfTicksPerActionData(session, iTickIncrement, true);
                if (iResult == MessageResult.Cancel)
                {
                    return ActionResult.UserExit;
                }

                for (int i = 0; i < listF.Count; i++)
                {
                    ExecuteSQLScript(session, listF[i].DirectoryPath, listF[i].FileName, isCustomActionData);

                    iResult = InstallProgress.DisplayActionData3(session, (i + 1).ToString(), iTotalTicks.ToString(), 
                        InstallUtilities.Right(Path.Combine(listF[i].DirectoryPath, listF[i].FileName), 200));
                    if (iResult == MessageResult.Cancel)
                    {
                        return ActionResult.UserExit;
                    }
                }

                return ActionResult.Success;
            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Exception raised when execute database script", ex, true);
                MessageBox.Show(ex.Message, "Error of scripts execution (ExecuteSQLScripts(Session session))", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return ActionResult.Failure;
            }
        }


        [CustomAction]
        public static ActionResult TestSqlConnection(Session session)
        {
            try
            {
                if (session == null)
                {
                    throw new ArgumentNullException("session");
                }

                SetSessionProperty(session, "DATABASE_TEST_CONNECTION", "0");
                string sConnectionString = GetConnectionString(session, false);
                using (SqlConnection sqlConect = new SqlConnection(sConnectionString))
                {
                    sqlConect.Open();
                }
                SetSessionProperty(session, "DATABASE_TEST_CONNECTION", "1");


            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Exception when performing test connection to the database server.", ex, true);
                MessageBox.Show(ex.Message, "Test failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            return ActionResult.Success;
        }
        #endregion Custom actions

        #region Private methods
        private static Assembly GetAssembly()
        { 
            if (InstallUtilities.AssemblyCurrent == null)
            {
                InstallUtilities.AssemblyCurrent = Assembly.GetExecutingAssembly();
            }
            return InstallUtilities.AssemblyCurrent;
        }

        private static SqlConnection GetConnection(Session session, bool isCustomActionData)
        {
            string sConnectionString;
            try
            {
                if (m_sqlConectionMain == null || m_sqlConectionMain.State == System.Data.ConnectionState.Closed)
                {
                    sConnectionString = GetConnectionString(session, isCustomActionData);

                    m_sqlConectionMain.ConnectionString = sConnectionString;
                    m_sqlConectionMain.Open();
                }
                return m_sqlConectionMain;
            }
            catch
            {
                throw;
            }
        }

        private static string GetConnectionString(Session session, bool isCustomActionData)
        {
            string sConnectionString;

            if (GetSessionProperty(session, "DATABASE_WINDOWSAUTHENTICATION", isCustomActionData) == "1")
            {
                sConnectionString = string.Format("Integrated Security=SSPI;Persist Security Info=False;Data Source={0};",
                    GetSessionProperty(session, "DATABASE_SERVERNAME", isCustomActionData).Trim());
            }
            else
            {
                sConnectionString = string.Format("Persist Security Info=False;Data Source={0};User ID={1};Password={2};",
                    GetSessionProperty(session, "DATABASE_SERVERNAME", isCustomActionData), 
                    GetSessionProperty(session, "DATABASE_USERNAME", isCustomActionData), 
                    GetSessionProperty(session, "DATABASE_PASSWORD", isCustomActionData));
            }

            if (GetSessionProperty(session, "DATABASE_AUTHENTICATEDATABASE", isCustomActionData) == "1")
            {
                sConnectionString += string.Format("Initial Catalog={0};", GetSessionProperty(session, "DATABASE_NAME", isCustomActionData));
            }
            return sConnectionString;
        }

        private static string GetSQLScriptFromAssembly(string path, string fileName)
        {
            StreamReader reader = null;
            string sFile = null;
            try
            {
                Assembly asm = GetAssembly();
                sFile = asm.GetName().Name + "." + path.Replace("\\", ".") + "." + fileName;

                Stream strm = asm.GetManifestResourceStream(sFile);
                reader = new StreamReader(strm);
                return reader.ReadToEnd();
            }
            catch (Exception ex)
            {
                throw new InstallerException("Fail to read file: " + (string.IsNullOrEmpty(sFile) ? "" : sFile), ex);
            }
            finally
            {
                try
                {
                    if (reader != null)
                    {
                        reader.Close();
                    }
                }
                catch
                { }
            }
        }


        private static string GetSQLScriptFromFile(string path, string fileName)
        {
            string f = Path.Combine(path, fileName);
            if (File.Exists(f))
            {
                TextReader r = new StreamReader(f, Encoding.Default); 
                try
                {
                    return r.ReadToEnd();
                }
                finally
                {
                    try
                    {
                        r.Close();
                    }
                    catch
                    { }
                }
            }
            else
            {
                throw new InstallerException("Cannot find file: " + (string.IsNullOrEmpty(f) ? "" : f));
            }
        }


        private static bool ExecuteSQLScript(Session session, string path, string fileName, bool isCustomActionData)
        {
            return ExecuteSQLScript(session, path, fileName, true, isCustomActionData);
        }

        private static bool ExecuteSQLScript(Session session, string path, string fileName, bool usingTransaction, bool isCustomActionData)
        {
            bool bOK = true;
            string sCommandText = "", sScript = null, sMessage;
            SqlCommand command = new SqlCommand();
            SqlConnection cnx;
            try
            {
                InstallUtilities.WriteLogInstall(session, string.Format("Begin ExecuteSQL, Path: {0}, Filename: {1} ...", path, fileName), null, false);

                sScript = GetSQLScriptFromFile(path, fileName).Trim();
                
                sScript = ReplaceVariables(session, sScript, isCustomActionData);
                if (string.IsNullOrWhiteSpace(sScript))
                {
                    return true;
                }

                cnx = GetConnection(session, isCustomActionData);
                command.CommandType = System.Data.CommandType.Text;
                command.CommandTimeout = 0;
                command.Connection = cnx;

                string[] splits = new string[] { "GO\n", "GO\r\n", "GO\t", "GO \r\n", "GO \n", "GO  \r\n", "GO  \n", "GO   \n", "GO   \r\n", "GO    \r\n" };
                string[] sSQL = sScript.Split(splits, StringSplitOptions.RemoveEmptyEntries);

                if (usingTransaction)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        foreach (string s in sSQL)
                        { 

                            sCommandText = s.Trim();
                            if (sCommandText.EndsWith("GO", StringComparison.OrdinalIgnoreCase))
                            {
                                sCommandText = sCommandText.Substring(0, sCommandText.Length - 2);
                            }

                            if (string.IsNullOrWhiteSpace(sCommandText))
                                continue;

                            
                            command.CommandText = sCommandText;
                            command.ExecuteNonQuery();
                        }
                        scope.Complete();
                    }
                }
                else
                {
                    foreach (string s in sSQL)
                    {
                        sCommandText = s.Trim();
                        if (sCommandText.EndsWith("GO", StringComparison.OrdinalIgnoreCase))
                        {
                            sCommandText = sCommandText.Substring(0, sCommandText.Length - 2);
                        }

                        if (string.IsNullOrWhiteSpace(sCommandText))
                            continue;

                        command.CommandText = sCommandText;
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                bOK = false;
                sMessage = "Exception when running script: " + Path.Combine(path, fileName);
                InstallUtilities.WriteLogInstall(session, sMessage, ex, true);
                InstallUtilities.WriteLogInstall(session, "COMMAND EXECUTED:", null, false);
                InstallUtilities.WriteLogInstall(session, sCommandText, null, false);

                sCommandText = sCommandText.Length > 1000 ? sCommandText.Substring(0, 1000) + " ..." : sCommandText;
                sCommandText = sMessage + Environment.NewLine + Environment.NewLine +
                    " Exception: " + ex.Message + Environment.NewLine + Environment.NewLine + sCommandText;

                MessageBox.Show(sCommandText+ ex.Message, "Fail to execute sql", MessageBoxButtons.OK, MessageBoxIcon.Error);

                if (MessageBox.Show("Do you want to continue running the following script?" + Environment.NewLine + Environment.NewLine +
                    "If No installation will be aborted. ", " Continue Installation",
                    MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                {
                    bOK = true;
                }
                else
                {
                    throw new InstallerException(sMessage + ". " + ex.Message);
                }
            }
            finally
            {
                command.Dispose();
            }

            return bOK;
        }

        private static string ReplaceVariables(Session session, string script, bool isCustomActionData)
        {
            int i;
            string sPath;
            if (string.IsNullOrWhiteSpace(script))
                return script;

            script = script.Replace("$(DATABASE_NAME)", GetSessionProperty(session, "DATABASE_NAME", isCustomActionData));

            //script = script.Replace("$(DATABASE_MAILPROFILENAME)", GetSessionProperty(session, "DATABASE_MAILPROFILENAME", isCustomActionData));
            //script = script.Replace("$(DATABASE_MAILBOX)", GetSessionProperty(session, "DATABASE_MAILBOX", isCustomActionData));
            //script = script.Replace("$(DATABASE_MAILIP)", GetSessionProperty(session, "DATABASE_MAILIP", isCustomActionData));
            //script = script.Replace("$(DATABASE_OPERATORMAILBOX)", GetSessionProperty(session, "DATABASE_OPERATORMAILBOX", isCustomActionData));
            //script = script.Replace("$(DATABASE_PROXYWINDOWSUSER)", GetSessionProperty(session, "DATABASE_PROXYWINDOWSUSER", isCustomActionData));
            //script = script.Replace("$(DATABASE_PROXYPASSWORD)", GetSessionProperty(session, "DATABASE_PROXYPASSWORD", isCustomActionData));

            List<DataBasePathTO> listPaths = GetCustomTableDataBasePaths(session, isCustomActionData);
            for (i = 0; i < listPaths.Count; i++)
            {
                if (listPaths[i].Path.EndsWith("\\"))
                {
                    sPath = listPaths[i].Path.Substring(0, listPaths[i].Path.Length - 1);
                }
                else
                {
                    sPath = listPaths[i].Path;
                }
                script = script.Replace("$(" + listPaths[i].Name + ")", sPath);
            }

            return script;
        }

        [CustomAction]
        public static ActionResult SwhowPathInstall(Session session)
        {
            try
            {

                bool isCustomActionData = false;
                List<DataBasePathTO> listPaths;
                List<FeactureInstallTO> listFeactureScripts;
                List<string> listFeactureNames = new List<string>();

                InstallUtilities.WriteLogInstall(session, "Starting SwhowPathInstall ...", null, true);
                if (session == null)
                {
                    throw new ArgumentNullException("session");
                }
                
                listPaths = GetCustomTableDataBasePaths(session, isCustomActionData);
                
                CustomActionData data = new CustomActionData();

                data.AddObject<List<DataBasePathTO>>("DATABASE_PATHS", listPaths);

                SetCustomActionData(session, "INSTALLLOCATION", data);
                SetCustomActionData(session, "DATABASE_SERVERNAME", data);
                SetCustomActionData(session, "DATABASE_NAME", data);
                SetCustomActionData(session, "DATABASE_WINDOWSAUTHENTICATION", data);
                SetCustomActionData(session, "DATABASE_AUTHENTICATEDATABASE", data);
                SetCustomActionData(session, "DATABASE_EXECUTESCRIPTS", data);
                SetCustomActionData(session, "DATABASE_USERNAME", data);
                SetCustomActionData(session, "DATABASE_PASSWORD", data);

                //SetCustomActionData(session, "DATABASE_PROXYPASSWORD", data);
                //SetCustomActionData(session, "DATABASE_MAILPROFILENAME", data);
                //SetCustomActionData(session, "DATABASE_MAILBOX", data);
                //SetCustomActionData(session, "DATABASE_MAILIP", data);
                //SetCustomActionData(session, "DATABASE_OPERATORNAMENAME", data);
                //SetCustomActionData(session, "DATABASE_OPERATORMAILBOX", data);
                //SetCustomActionData(session, "DATABASE_PROXYWINDOWSUSER", data);

                foreach (FeatureInfo fi in session.Features)
                {
                    if (fi.RequestState == InstallState.Local || fi.RequestState == InstallState.Source || fi.RequestState == InstallState.Default)
                    {
                        listFeactureNames.Add(fi.Name);
                        InstallUtilities.WriteLogInstall(session, "FEATURE fi.Name: " + fi.Name + ", fi.CurrentState: " + fi.CurrentState +
                            ", fi.RequestState:" + fi.RequestState, null, false);
                    }
                }
                listFeactureScripts = GetFeactureScriptDataBase(session, listFeactureNames);
                data.AddObject<List<FeactureInstallTO>>("DATABASE_FEACTURESCRIPTS", listFeactureScripts);

                //session["CUSTOMACTIONDATA_PROPERTIES"] = data.ToString();

                session.DoAction("CA_DataBaseExecuteScripts", data);

                return ActionResult.Success;
            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Exception to establish routes database installation", ex, true);
                return ActionResult.Failure;
            }
        }
        #endregion Private methods

        #region Session methods
        private static List<DataBasePathTO> GetCustomTableDataBasePaths(Session session, bool isCustomActionData)
        {
            try
            {
                List<DataBasePathTO> listPaths;

                if (isCustomActionData)
                {
                    listPaths = session.CustomActionData.GetObject<List<DataBasePathTO>>("DATABASE_PATHS");
                }
                else
                {
                    listPaths = new List<DataBasePathTO>();
                    DataBasePathTO path;
                    string sPath;
                    using (Microsoft.Deployment.WindowsInstaller.View v = session.Database.OpenView
                        ("SELECT * FROM `TABLE_DATABASE_PATHS`"))
                    {
                        if (v != null)
                        {
                            v.Execute();
                            for (Record r = v.Fetch(); r != null; r = v.Fetch())
                            {
                                sPath = r.GetString(3);
                                if (string.IsNullOrWhiteSpace(sPath))
                                {
                                    sPath = GetSessionProperty(session, "INSTALLLOCATION", isCustomActionData);
                                }

                                path = new DataBasePathTO()
                                {
                                    Name = r.GetString(1),
                                    Description = r.GetString(2),
                                    Path = sPath
                                };
                                listPaths.Add(path);
                                r.Dispose();
                            }
                        }
                    }
                }

                if (listPaths == null || listPaths.Count == 0)
                {
                    throw new InstallerException("No installation paths configured");
                }
                return listPaths;
            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Exception, GetCustomTableDataBasePaths", ex, true);
                throw;
            }
        }

        private static List<FeactureInstallTO> GetFeactureScriptDataBase(Session session, List<string> listFeactureNames)
        { 
            string sFileName=string.Empty ;
            try
            {
                List<FeactureInstallTO> listF;

                string sLevel = session["INSTALLLEVEL"];
                listF = new List<FeactureInstallTO>();
                FeactureInstallTO f;
                int i;
               
                string sQuery = "SELECT `Feature`.`Feature`, `Feature`.`Title`, `Feature`.`Display`, " +
                    " `Component`.`Directory_`, `File`.`FileName` " +
                    " FROM `FeatureComponents`, `Feature`, `Component`, `File` " +
                    " WHERE `FeatureComponents`.`Feature_` = `Feature`.`Feature` " +
                    " AND `FeatureComponents`.`Component_` = `Component`.`Component` " +
                    " AND `File`.`Component_` = `Component`.`Component` " +
                    " AND `Feature`.`RuntimeLevel` > 0 AND `Feature`.`Level` > 0 " +
                    // " AND `Feature`.`Level` <= " + sLevel +
                    " ORDER BY `Feature`.`Display`";
                using (Microsoft.Deployment.WindowsInstaller.View v = session.Database.OpenView(sQuery))
                {
                    if (v != null)
                    {
                        v.Execute();

                        //var str = string.Empty;
                        //foreach (var fea in listFeactureNames)
                        //    str += fea.ToString();

                        //MessageBox.Show(str);
                        //str = string.Empty ;

                        //var frm = new FeatureList( session,v,listFeactureNames);
                        //frm.ShowDialog();

                        for (Record r = v.Fetch(); r != null; r = v.Fetch())
                        {
                            if (listFeactureNames.Contains(r.GetString("Feature")) && r.GetString("FileName").ToUpper().EndsWith(".SQL"))
                            {
                                i = r.GetString("FileName").IndexOf("|");
                                if (i > 0)
                                {
                                    sFileName = r.GetString("FileName").Substring(i + 1);
                                }
                                else
                                {
                                    sFileName = r.GetString("FileName");
                                }

                                f = new FeactureInstallTO()
                                {
                                    Feature = r.GetString("Feature"),
                                    Title = r.GetString("Title"),
                                    DisplayOrder = r.GetInteger("Display"),
                                    FileName = sFileName,
                                    DirectoryPath = session.GetTargetPath(r.GetString("Directory_"))
                                };
                                listF.Add(f);
                            }
                            r.Dispose();
                        }

                    }
                }
                return listF;
            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Fail to Read Feature Script", ex, true);
                throw;
            }
        }

        private static string GetSessionProperty(Session session, string propertyName, bool isCustomActionData)
        {
            if (isCustomActionData)
            {
                return session.CustomActionData[propertyName];
            }
            else // if (session.GetMode(InstallRunMode.Scheduled))
            {
                return session[propertyName];
            }
        }

        private static void SetCustomActionData(Session session, string propertyName)
        {
            if (session.CustomActionData.ContainsKey(propertyName))
                session.CustomActionData[propertyName] = session[propertyName];
            else
                session.CustomActionData.Add(propertyName, session[propertyName]);
        }

        private static void SetCustomActionData(Session session, string propertyName, CustomActionData data)
        {
            if (data.ContainsKey(propertyName))
                data[propertyName] = session[propertyName];
            else
                data.Add(propertyName, session[propertyName]);
        }

        private static void SetSessionProperty(Session session, string propertyName, string value)
        {
            try
            {
                session[propertyName] = value;
            }
            catch
            {
                
            }
        }

        public static void UpdateCustomTableDataBasePaths(Session session, List<DataBasePathTO> listPaths, bool isCustomActionData)
        {
            try
            {
                Record record;
                Microsoft.Deployment.WindowsInstaller.View viewWI;

                if (listPaths == null || listPaths.Count < 0)
                    return;

                if (session == null)
                {
                    throw new ArgumentNullException("session");
                }

                if (isCustomActionData)
                {
                    if (session.CustomActionData.ContainsKey("DATABASE_PATHS"))
                    {
                        session.CustomActionData.Remove("DATABASE_PATHS");
                        session.CustomActionData.AddObject<List<DataBasePathTO>>("DATABASE_PATHS", listPaths);
                    }
                    else
                    {
                        session.CustomActionData.AddObject<List<DataBasePathTO>>("DATABASE_PATHS", listPaths);
                    }
                }
                else
                {
                    TableInfo info = session.Database.Tables["TABLE_DATABASE_PATHS"];
                    viewWI = session.Database.OpenView("SELECT * FROM TABLE_DATABASE_PATHS");
                    for (int i = 0; i < listPaths.Count; i++)
                    {
                        record = session.Database.CreateRecord(info.Columns.Count);
                        record.FormatString = info.Columns.FormatString;

                        record[1] = listPaths[i].Name;
                        record[2] = listPaths[i].Description;
                        record[3] = listPaths[i].Path;

                        viewWI.Modify(ViewModifyMode.InsertTemporary, record);
                        record.Dispose();
                    }
                    viewWI.Close();
                }
            }
            catch (Exception ex)
            {
                InstallUtilities.WriteLogInstall(session, "Exception to update rows of CustomTable", ex, true);
                throw;
            }
        }
        #endregion Session methods
    }
}
