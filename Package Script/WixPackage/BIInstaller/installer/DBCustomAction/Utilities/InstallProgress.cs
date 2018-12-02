using Microsoft.Deployment.WindowsInstaller;

namespace CustomAction.Utilities
{
    public static class InstallProgress
    {
        public static MessageResult ResetProgress(Session session, int totalTicks)
        {
            Record record = new Record(4);
            record[1] = "0"; 
            
            record[2] = totalTicks.ToString(); // Total ticks

            record[3] = "0";

            record[4] = "0";

            return session.Message(InstallMessage.Progress, record);
        }

        public static MessageResult NumberOfTicksPerActionData(Session session, int ticks, bool increaseForActionData)
        {
            Record record = new Record(3);
            record[1] = "1"; 
            
            record[2] = ticks.ToString();

            if (increaseForActionData)
            {
                record[3] = "1"; 
            }
            else
            {
                record[3] = "0"; 
            }
            return session.Message(InstallMessage.Progress, record);
        }

        public static MessageResult DisplayActionData(Session session, string message)
        {
            Record record = new Record(1);
            record[1] = message;
            return session.Message(InstallMessage.ActionData, record);
        }

        public static MessageResult DisplayActionData2(Session session, string parameter1, string parameter2)
        {
            Record record = new Record(2);
            record[1] = parameter1;
            record[2] = parameter2;
            return session.Message(InstallMessage.ActionData, record);
        }

        public static MessageResult DisplayActionData3(Session session, string parameter1, string parameter2, string parameter3)
        {
            Record record = new Record(3);
            record[1] = parameter1;
            record[2] = parameter2;
            record[3] = parameter3;
            return session.Message(InstallMessage.ActionData, record);
        }

        public static MessageResult DisplayStatusActionStart(Session session, string actionName, string status, string template)
        {
                Record record = new Record(3);
                record[1] = actionName;
                record[2] = status;
                record[3] = template;
                return session.Message(InstallMessage.ActionStart, record);
        }

        public static MessageResult IncrementTotalTicks(Session session, int totalTicks)
        {
            Record record = new Record(2);
            record[1] = "3";
            record[2] = totalTicks.ToString();
            return session.Message(InstallMessage.Progress, record);
        }

        public static MessageResult IncrementProgress(Session session, int tickIncrement)
        {
            Record record = new Record(2);
            record[1] = "2"; 
            record[2] = tickIncrement.ToString(); 
            return session.Message(InstallMessage.Progress, record);
        }

        public static void ThrowInstallError(Session session, string errorMessage)
        {
            Record record = new Record(1);
            record[1] = errorMessage;

            session.Message(InstallMessage.FatalExit, record);
        }

    }
}
