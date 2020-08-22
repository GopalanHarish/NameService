using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class FileCreate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string file = filetb.Text;
                System.IO.File.WriteAllText(file,"harishtesting");
                outputlb.Text = "success created file - " + file;
            }
            catch(Exception ex)
            {
                outputlb.Text = ex.Message;
            }            
        }
    }
}