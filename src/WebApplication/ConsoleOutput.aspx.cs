using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class ConsoleOutput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var client = new WebClient())
            {
                //client.Credentials = new NetworkCredential(ftpUsername, ftpPassword);
                //System.IO.File.WriteAllText("tmp.txt", message);
                outputlb.Text = client.DownloadString("ftp://localhost/consoleoutput.txt");
            }
        }
    }
}