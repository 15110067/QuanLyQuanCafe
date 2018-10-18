using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QuanLyQuanCafe.DAO
{
    public class TableDAO
    {
        private static TableDAO instance;

        public static TableDAO Instance
        {
            get { if (instance == null) instance = new TableDAO(); return TableDAO.instance; }
            private set { TableDAO.Instance = value; }
        }

        public static int TableWidth = 90;
        public static int TableHeigth = 90;

        private TableDAO() { }

        public void SwitchTable(int id1, int id2)
        {
            DataProvider.Instance.ExecuteQuery("USP_SwitchTable @idTable1 , @idTable2", new object[] { id1, id2 });
        }

        public List<Table> LoadTableList()
        {
            List<Table> tableList = new List<Table>();

            DataTable data = DataProvider.Instance.ExecuteQuery("USP_GetTableList");

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                tableList.Add(table);
            }

            return tableList;
        }

        public List<Table> GetListTable()
        {
            List<Table> list = new List<Table>();

            string query = "SELECT * FROM TableFood";

            DataTable data = DataProvider.Instance.ExecuteQuery(query);

            foreach (DataRow item in data.Rows)
            {
                Table table = new Table(item);
                list.Add(table);
            }

            return list;
        }

        public bool InsertTableFood(string name)
        {
            string query = string.Format("INSERT INTO dbo.TableFood ( name ) VALUES  ( N'{0}' )", name);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }
        public bool UpdateTableFood(int id, string name)
        {
            string query = string.Format("UPDATE dbo.TableFood SET name = N'{0}' WHERE id = {1}", name, id);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }

        public bool DeleteTableFood(int id)
        {
            string query = string.Format("DELETE dbo.TableFood where id = {0}", id);
            int result = DataProvider.Instance.ExecuteNoneQuery(query);

            return result > 0;
        }
    }
}
