using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class AccountDAO
    {
        private static AccountDAO instance;

        public static AccountDAO Instance
        {
            get { if (instance == null) instance = new AccountDAO(); return instance; }
            private set { instance = value; } 
        }

        private AccountDAO() { }

        public bool Login(string userName, string password)
        {
            byte[] temp = ASCIIEncoding.ASCII.GetBytes(password);
            byte[] hasData = new MD5CryptoServiceProvider().ComputeHash(temp);

            string hasPass = "";

            foreach (byte item in hasData)
            {
                hasPass += item;
            }
            //var list = hasData.ToString();
            //list.Reverse();

            string query = "USP_Login @userName , @passWord";

            DataTable result = DataProvider.Instance.ExecuteQuery(query, new object[] { userName, hasPass });

            return result.Rows.Count > 0;
        }

        public bool UpdateAccount(string userName, string displayName, string pass, string newPass)
        {
            int result = DataProvider.Instance.ExecuteNoneQuery("EXEC USP_UpdateAccount @userName , @displayName , @password , @newPassword ", new object[] { userName, displayName, pass, newPass });

            return result > 0;
        }

        public Account GetAccountByUserName(string userName)
        {
            DataTable data = DataProvider.Instance.ExecuteQuery("SELECT * FROM Account WHERE userName = '" + userName + "'");

            foreach (DataRow item in data.Rows)
            {
                return new Account(item);
            }

            return null;
        }

        public DataTable GetListAccount()
        {
            return DataProvider.Instance.ExecuteQuery("SELECT userName, displayName, type FROM Account ");
        }

        public bool InsertAccount(string username, string displayname, int type)
        {
            string query = string.Format("INSERT INTO dbo.Account ( username, displayname, type, password ) VALUES  ( N'{0}', N'{1}', {2}, N'{3}')", username, displayname, type, "1962026656160185351301320480154111117132155");
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }
        public bool UpdateAccount(string username, string displayname, int type)
        {
            string query = string.Format("UPDATE dbo.Account SET displayname = N'{1}', type = {2} WHERE username = N'{0}'", username, displayname, type);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }

        public bool DeleteAccount(string username)
        {
            string query = string.Format("DELETE Account where username = N'{0}'", username);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }

        public bool ResetPass(string username)
        {
            string query = string.Format("Update Account SET password = N'1962026656160185351301320480154111117132155' where username = N'{0}'", username);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }
    }
}
