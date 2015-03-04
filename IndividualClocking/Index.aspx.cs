using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

namespace IndividualClocking
{
    public partial class Index : System.Web.UI.Page
    {
        private void BindOnDateChanged()
        {
            string str = this.Calendar1.SelectedDate.ToString("yyyy-MM-dd");
            string cmdText = "SELECT Date_Format(create_time, '%a') AS The_day, " +
                             "Date_Format(create_time, '%Y-%m-%d') AS The_date, " +
                             "Date_Format(create_time, '%H:%i:%s') AS The_Time, " +
                             "(state_name) AS The_State " +
                             "FROM zkeco_db.acc_monitor_log " +
                             "WHERE create_time >= ADDDATE('" + str + "', - 30) " +
                             "AND date_format(create_time, '%Y-%m-%d') <='" + str + "' " +
                             "AND state_name like 'reception%'AND CONCAT(firstname,' ', lastname) like @Name " +
                             "order by The_date desc , the_Time desc";
            string connectionString = ConfigurationManager.ConnectionStrings["Names"].ConnectionString;
            MySqlCommand command = new MySqlCommand(cmdText);
            command.Parameters.AddWithValue("@Name", this.ddlNames.SelectedItem.Value);
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlDataAdapter adapter = new MySqlDataAdapter())
                {
                    command.Connection = connection;
                    adapter.SelectCommand = command;
                    using (DataSet set = new DataSet())
                    {
                        adapter.Fill(set);
                        this.IndividualINOUT.DataSource = set;
                        this.IndividualINOUT.DataBind();
                    }
                }
            }
        }
        private void SummarisedClock()
        {
            string str = this.Calendar1.SelectedDate.ToString("yyyy-MM-dd");
            string cmdText = "SELECT * FROM\r\n                        (SELECT Date_Format(create_time, '%a') AS The_day, Date_Format(create_time, '%Y-%m-%d') AS The_date, MAX(TIME(create_time)) AS The_Time, (state_name) AS The_State  FROM zkeco_db.acc_monitor_log WHERE create_time >= ADDDATE('" + str + "', - 30) AND date_format(create_time, '%Y-%m-%d') <='" + str + "' and state_name like '% out%'AND CONCAT(firstname,' ', lastname) like @Name group by The_date, firstname UNION ALL SELECT Date_Format(create_time, '%a') AS The_day, Date_Format(create_time, '%Y-%m-%d') AS The_date, MIN(TIME(create_time)) AS The_Time, (state_name) AS The_State FROM zkeco_db.acc_monitor_log WHERE create_time >= ADDDATE('" + str + "', - 30) AND date_format(create_time, '%Y-%m-%d') <='" + str + "'AND CONCAT(firstname,' ', lastname) like @Name and state_name like '% in%' group by The_date, firstname )AS RESULTS Order by The_date desc, The_Time";
            string connectionString = ConfigurationManager.ConnectionStrings["Names"].ConnectionString;
            MySqlCommand command = new MySqlCommand(cmdText);
            command.Parameters.AddWithValue("@Name", this.ddlNames.SelectedItem.Value);
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                using (MySqlDataAdapter adapter = new MySqlDataAdapter())
                {
                    command.Connection = connection;
                    adapter.SelectCommand = command;
                    using (DataSet set = new DataSet())
                    {
                        adapter.Fill(set);
                        this.IndividualINOUT.DataSource = set;
                        this.IndividualINOUT.DataBind();
                    }
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Page.IsPostBack)
            {
                this.BindOnDateChanged();
            }
            else
            {
                this.Calendar1.SelectedDate = Convert.ToDateTime(DateTime.Now.ToString(CultureInfo.InvariantCulture));
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            if (this.rbDetail.Checked)
            {
                this.BindOnDateChanged();
            }
            else if (this.rbSummary.Checked)
            {
                this.SummarisedClock();
            }
        }

        protected void IndividualINOUT_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            DataRowView dataItem = (DataRowView)e.Item.DataItem;
            switch (Convert.ToString(dataItem.Row["The_day"]))
            {
                case "Mon":
                    e.Item.BackColor = Color.Aqua;
                    return;

                case "Tue":
                    e.Item.BackColor = Color.LightCyan;
                    return;

                case "Wed":
                    e.Item.BackColor = Color.Pink;
                    return;

                case "Thu":
                    e.Item.BackColor = Color.Aquamarine;
                    break;

                case "Fri":
                    e.Item.BackColor = Color.Plum;
                    break;
            }
        }
    }
}