using QuanLyQuanCafe.DAO;
using QuanLyQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QuanLyQuanCafe
{
    public partial class FrmAdmin : Form
    {
        BindingSource foodList = new BindingSource();
        BindingSource categoryFoodList = new BindingSource();
        BindingSource tableFoodList = new BindingSource();
        BindingSource accountList = new BindingSource();

        public Account loginAccount;

        public FrmAdmin()
        {
            InitializeComponent();
            Load();
        }

        #region Methods
        void Load()
        {
            dgvFood.DataSource = foodList;
            dgvCategory.DataSource = categoryFoodList;
            dgvTable.DataSource = tableFoodList;
            dgvAccount.DataSource = accountList;

            LoadDateTimePickerBill();
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);

            LoadListFood();
            AddFoodBindding();
            LoadCatagoryIntoCombobox(cbFoodCategory);

            LoadListCategoryFood();
            AddCategoryFoodBindding();

            LoadListTableFood();
            AddTableFoodBindding();

            LoadAccount();
            AddAccountBindding();
        }

        List<Food> SearchFoodByName(string name)
        {
            List<Food> listFood = FoodDAO.Instance.SearchFoodByName(name);

            return listFood;
        }
     
        // Hiển thị Fromdate cho thành đầu tháng và Todate thành cuối tháng
        void LoadDateTimePickerBill()
        {
            DateTime today = DateTime.Now;
            dtpkFromDate.Value = new DateTime(today.Year, today.Month, 1);
            dtpkToDate.Value = dtpkFromDate.Value.AddMonths(1).AddDays(-1);
        }

        // Load danh sách hoá đơn theo ngày (thống kê)
        void LoadListBillByDate(DateTime checkIn, DateTime checkOut)
        {
            dgvBill.DataSource = BillDAO.Instance.GetBillListByDate(checkIn, checkOut);
        }
        
        // Load danh sách danh mục lên combobox
        void LoadCatagoryIntoCombobox(ComboBox cb)
        {
            cb.DataSource = CategoryDAO.Instance.GetListCategory();
            cb.DisplayMember = "Name";
        }
        
        #region Bindding data
        // Bindding dữ liệu từ datagridview Food sang textbox
        void AddFoodBindding()
        {
            txtFoodName.DataBindings.Add(new Binding("Text", dgvFood.DataSource, "Name", true, DataSourceUpdateMode.Never));
            txtIDFood.DataBindings.Add(new Binding("Text", dgvFood.DataSource, "ID", true, DataSourceUpdateMode.Never));
            nmFoodPrice.DataBindings.Add(new Binding("Value", dgvFood.DataSource, "Price", true, DataSourceUpdateMode.Never));
        }

        // Bindding dữ liệu từ datagridview Category sang textbox
        void AddCategoryFoodBindding()
        {
            txtIDCategory.DataBindings.Add(new Binding("Text", dgvCategory.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txtCategoryName.DataBindings.Add(new Binding("Text", dgvCategory.DataSource, "Name", true, DataSourceUpdateMode.Never));
        }

        // Bindding dữ liệu từ datagridview Table sang textbox
        void AddTableFoodBindding()
        {
            txtIDTable.DataBindings.Add(new Binding("Text", dgvTable.DataSource, "ID", true, DataSourceUpdateMode.Never));
            txtTableName.DataBindings.Add(new Binding("Text", dgvTable.DataSource, "Name", true, DataSourceUpdateMode.Never));
            txtTableStatus.DataBindings.Add(new Binding("Text", dgvTable.DataSource, "Status", true, DataSourceUpdateMode.Never));
        }
        
        // Bindding dữ liệu từ datagridview Account sang textbox
        void AddAccountBindding()
        {
            txtUserName.DataBindings.Add(new Binding("Text", dgvAccount.DataSource, "userName", true, DataSourceUpdateMode.Never));
            txtDisplayName.DataBindings.Add(new Binding("Text", dgvAccount.DataSource, "displayName", true, DataSourceUpdateMode.Never));
            nmAccountType.DataBindings.Add(new Binding("Value", dgvAccount.DataSource, "type", true, DataSourceUpdateMode.Never));
        }
        #endregion

        #region Load List
        
        // Load danh sách thức ăn
        void LoadListFood()
        {
            foodList.DataSource = FoodDAO.Instance.GetListFood();
        }
        
        // Load danh sách danh mục thức ăn
        void LoadListCategoryFood()
        {
            categoryFoodList.DataSource = CategoryDAO.Instance.GetListCategory();
        }
        
        // Load danh sách bàn ăn
        void LoadListTableFood()
        {
            tableFoodList.DataSource = TableDAO.Instance.GetListTable();
        }

        #endregion

        #region Account

        // Load danh sách account
        void LoadAccount()
        {
            accountList.DataSource = AccountDAO.Instance.GetListAccount();
        }
        
        // Thêm tài khoản
        void AddAcount(string username, string displayname, int type)
        {
            if(AccountDAO.Instance.InsertAccount(username, displayname, type))
            {
                MessageBox.Show("Thêm tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Thêm tài khoản thất bại");
            }

            LoadAccount();
        }

        //Sửa tài khoản
        void EditAcount(string username, string displayname, int type)
        {
            if (AccountDAO.Instance.UpdateAccount(username, displayname, type))
            {
                MessageBox.Show("Cập nhật tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Cập nhật tài khoản thất bại");
            }

            LoadAccount();
        }

        //Tài khoản
        void DeleteAcount(string username)
        {
            if (loginAccount.UserName.Equals(username))
            {
                MessageBox.Show("Đừng xoá tài khoản của bạn chớ!!");
                return;
            }
            if (AccountDAO.Instance.DeleteAccount(username))
            {
                MessageBox.Show("Xoá tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Xoá tài khoản thất bại");
            }

            LoadAccount();
        }

        // Đặt lại mật khẩu
        void ResetPass(string username)
        {
            if (AccountDAO.Instance.ResetPass(username))
            {
                MessageBox.Show("Đặt lại mật khẩu tài khoản thành công");
            }
            else
            {
                MessageBox.Show("Đặt lại mật khẩu tài khoản thất bại");
            }
        }

        #endregion

        #region Table Food
        void AddTableFood(string name)
        {
            if (TableDAO.Instance.InsertTableFood(name))
            {
                MessageBox.Show("Thêm thành công");
                LoadListTableFood();
                if (insertTableFood != null)
                    insertTableFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm");
            }
        }

        void EditTableFood(int id, string name)
        {
            if (TableDAO.Instance.UpdateTableFood(id, name))
            {
                MessageBox.Show("Sửa thành công");
                LoadListTableFood();
                if (updateTableFood != null)
                    updateTableFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa");
            }
        }

        void DeleteTable(int id)
        {
            if (TableDAO.Instance.DeleteTableFood(id))
            {
                MessageBox.Show("Xoá thành công");
                LoadListTableFood();
                if (deleteTableFood != null)
                    deleteTableFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xoá");
            }
        }
        #endregion

        #region Category Food
        void AddCategoryFood(string name)
        {
            if (CategoryDAO.Instance.InsertCategory(name))
            {
                MessageBox.Show("Thêm thành công");
                LoadListCategoryFood();
                LoadCatagoryIntoCombobox(cbFoodCategory);
                if (insertCategoryFood != null)
                    insertCategoryFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm");
            }
        }

        void EditCategory(int id, string name)
        {
            if (CategoryDAO.Instance.UpdateCategory(id, name))
            {
                MessageBox.Show("Sửa thành công");
                LoadListCategoryFood();
                LoadCatagoryIntoCombobox(cbFoodCategory);
                if (updateCategoryFood != null)
                    updateCategoryFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa");
            }
        }

        void DeleteCategory(int id)
        {
            if (CategoryDAO.Instance.DeleteCategory(id))
            {
                MessageBox.Show("Xoá thành công");
                LoadListCategoryFood();
                LoadCatagoryIntoCombobox(cbFoodCategory);
                if (deleteCategoryFood != null)
                    deleteCategoryFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xoá");
            }
        }
        #endregion

        #endregion

        #region Events
        #region Event Food

        private event EventHandler insertFood;
        public event EventHandler InsertFood
        {
            add { insertFood += value; }
            remove { insertFood -= value; }
        }

        private event EventHandler updateFood;
        public event EventHandler UpdateFood
        {
            add { updateFood += value; }
            remove { updateFood -= value; }
        }

        private event EventHandler deleteFood;
        public event EventHandler DeleteFood
        {
            add { deleteFood += value; }
            remove { deleteFood -= value; }
        }

        private void btnViewBill_Click(object sender, EventArgs e)
        {
            LoadListBillByDate(dtpkFromDate.Value, dtpkToDate.Value);
        }
        
        private void btnViewFood_Click(object sender, EventArgs e)
        {
            LoadListFood();
        }
        
        private void txtIDFood_TextChanged(object sender, EventArgs e)
        {
            try
            {
                if (dgvFood.SelectedCells.Count > 0)
                {
                    int id = (int)dgvFood.SelectedCells[0].OwningRow.Cells["idCategory"].Value;

                    Category category = CategoryDAO.Instance.GetCategoryByID(id);

                    cbFoodCategory.SelectedItem = category;

                    int index = -1;
                    int i = 0;
                    foreach (Category item in cbFoodCategory.Items)
                    {
                        if (item.ID == category.ID)
                        {
                            index = i;
                            break;
                        }
                        i++;
                    }

                    cbFoodCategory.SelectedIndex = index;
                }
            }
            catch { }
        }
        
        private void btnAddFood_Click(object sender, EventArgs e)
        {
            string name = txtFoodName.Text;
            int categoryID = (cbFoodCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;

            if (FoodDAO.Instance.InsertFood(name, categoryID, price))
            {
                MessageBox.Show("Thêm thành công");
                LoadListFood();
                if (insertFood != null)
                    insertFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi thêm");
            }
        }

        private void btnEditFood_Click(object sender, EventArgs e)
        {
            string name = txtFoodName.Text;
            int categoryID = (cbFoodCategory.SelectedItem as Category).ID;
            float price = (float)nmFoodPrice.Value;
            int id = Convert.ToInt32(txtIDFood.Text);

            if (FoodDAO.Instance.UpdateFood(id, name, categoryID, price))
            {
                MessageBox.Show("Sửa thành công");
                LoadListFood();
                if (updateFood != null)
                    updateFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi sửa");
            }
        }

        private void btnDeleteFood_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txtIDFood.Text);

            if (FoodDAO.Instance.DeleteFood(id))
            {
                MessageBox.Show("Xoá thành công");
                LoadListFood();
                if (deleteFood != null)
                    deleteFood(this, new EventArgs());
            }
            else
            {
                MessageBox.Show("Có lỗi khi xoá");
            }
        }

        #endregion

        #region Event Category Food
        private event EventHandler insertCategoryFood;
        public event EventHandler InsertCategoryFood
        {
            add { insertCategoryFood += value; }
            remove { insertCategoryFood -= value; }
        }

        private event EventHandler updateCategoryFood;
        public event EventHandler UpdateCategoryFood
        {
            add { updateCategoryFood += value; }
            remove { updateCategoryFood -= value; }
        }

        private event EventHandler deleteCategoryFood;
        public event EventHandler DeleteCategoryFood
        {
            add { deleteCategoryFood += value; }
            remove { deleteCategoryFood -= value; }
        }

        private void btnAddCategory_Click(object sender, EventArgs e)
        {
            string name = txtCategoryName.Text;

            AddCategoryFood(name);
        }

        private void btnShowCategory_Click(object sender, EventArgs e)
        {
            LoadListCategoryFood();
        }

        private void btnEditCategory_Click(object sender, EventArgs e)
        {
            string name = txtCategoryName.Text;
            int id = Convert.ToInt32(txtIDCategory.Text);

            EditCategory(id, name);
        }

        private void btnDeleteCategory_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txtIDCategory.Text);

            DeleteCategory(id);
        }
        #endregion

        #region Event Table
        private event EventHandler insertTableFood;
        public event EventHandler InsertTableFood
        {
            add { insertTableFood += value; }
            remove { insertTableFood -= value; }
        }

        private event EventHandler updateTableFood;
        public event EventHandler UpdateTableFood
        {
            add { updateTableFood += value; }
            remove { updateTableFood -= value; }
        }

        private event EventHandler deleteTableFood;
        public event EventHandler DeleteTableFood
        {
            add { deleteTableFood += value; }
            remove { deleteTableFood -= value; }
        }

        private void btnShowTable_Click(object sender, EventArgs e)
        {
            LoadListTableFood();
        }

        private void btnDeleteTable_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32(txtIDTable.Text);

            DeleteTable(id);
        }

        private void btnEditTable_Click(object sender, EventArgs e)
        {
            string name = txtTableName.Text;
            int id = Convert.ToInt32(txtIDTable.Text);

            EditTableFood(id, name);
        }

        private void btnAddTable_Click(object sender, EventArgs e)
        {
            string name = txtTableName.Text;

            AddTableFood(name);
        }
        
        private void btnSearchFood_Click(object sender, EventArgs e)
        {
            foodList.DataSource = SearchFoodByName(txtSearchFoodName.Text);
        }

        #endregion

        #region Event Account

        private void btnShowAccount_Click(object sender, EventArgs e)
        {
            LoadAccount();
        }

        private void btnAddAccount_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;
            string displayname = txtDisplayName.Text;
            int type = (int)nmAccountType.Value;

            AddAcount(username, displayname, type);
        }

        private void btnEditAccount_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;
            string displayname = txtDisplayName.Text;
            int type = (int)nmAccountType.Value;

            EditAcount(username, displayname, type);
        }

        private void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;

            DeleteAcount(username);
        }

        private void btnResetPassWord_Click(object sender, EventArgs e)
        {
            string username = txtUserName.Text;

            ResetPass(username);
        }

        #endregion

        #endregion

        private void btnFirstPage_Click(object sender, EventArgs e)
        {
            txtPageView.Text = "1";
        }

        private void btnLastPage_Click(object sender, EventArgs e)
        {
            int sumRecord = BillDAO.Instance.GetNumBillByDate(dtpkFromDate.Value, dtpkToDate.Value);

            int lastPage = sumRecord / 10;

            if (sumRecord % 10 != 0)
                lastPage++;
            txtPageView.Text = lastPage.ToString();
        }

        private void txtPageView_TextChanged(object sender, EventArgs e)
        {
            dgvBill.DataSource = BillDAO.Instance.GetBillListByDateAndPage(dtpkFromDate.Value, dtpkToDate.Value, Convert.ToInt32(txtPageView.Text));
        }

        private void btnPreviousPage_Click(object sender, EventArgs e)
        {
            int page = Convert.ToInt32(txtPageView.Text);

            if (page > 1)
                page--;
            txtPageView.Text = page.ToString();
        }

        private void btnNextPage_Click(object sender, EventArgs e)
        {
            int page = Convert.ToInt32(txtPageView.Text);
            int sumRecord = BillDAO.Instance.GetNumBillByDate(dtpkFromDate.Value, dtpkToDate.Value);

            if (page < sumRecord)
                page++;
            txtPageView.Text = page.ToString();
        }
    }
}