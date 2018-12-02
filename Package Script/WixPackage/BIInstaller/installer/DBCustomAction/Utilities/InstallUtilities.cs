using System;
using System.Reflection;
using System.Windows.Forms;
using System.Threading;
using Microsoft.Deployment.WindowsInstaller;

namespace CustomAction.Utilities
{
    public static class InstallUtilities
    {
        #region Fields
        public static Assembly AssemblyCurrent;
        #endregion Fields

        #region Methods
        public static string GetFolder(string folderDefault)
        {
            string sPath = folderDefault;
            var t = new Thread((ThreadStart)(() =>
            {
                FolderBrowserDialog fbd = new FolderBrowserDialog();
                fbd.RootFolder = System.Environment.SpecialFolder.MyComputer;
                fbd.Description = "Select a folder";
                fbd.SelectedPath = folderDefault;
                fbd.ShowNewFolderButton = true;
                if (fbd.ShowDialog() == DialogResult.OK)
                {
                    sPath = fbd.SelectedPath;
                }
                else
                {
                    return;
                }
            }));
            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();
            return sPath;
        }

        public static string Right(string text, int length)
        {
            if (length < 0)
            {
                throw new ArgumentOutOfRangeException("length");
            }
            else if (length == 0 || text.Length == 0)
            {
                return "";
            }
            else if (string.IsNullOrEmpty(text))
            {
                return text;
            }
            else if (text.Length <= length)
            {
                return text;
            }
            else
            {
                return text.Substring(text.Length - length, length);
            }

        }


        public static void WriteLogInstall(Session session, string message, Exception ex, bool includeLine)
        {
            if (session != null)
            {
                if (includeLine)
                {
                    session.Log(DateTime.Now.ToString("MM-dd-yyyy HH:mm:ss") + ": ============================================================" );
                }
                if (!string.IsNullOrWhiteSpace(message))
                {
                    session.Log(message);
                }
                if (ex != null)
                {
                    session.Log("Exception:");
                    session.Log(ex.Message);
                }
            }
        }
        #endregion Methods
    }

    public class DataBasePathTO
    {
        public string Name { get; set; }

        public string Description { get; set; }

        public string Path { get; set; }
    }

    public class FeactureInstallTO
    {

        public string Feature { get; set; }
        public string Title { get; set; }
        public string DirectoryPath { get; set; }
        public string FileName { get; set; }
        public int DisplayOrder { get; set; }
    }
}
