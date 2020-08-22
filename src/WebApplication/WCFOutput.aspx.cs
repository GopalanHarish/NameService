using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class WCFOutput : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            myWCFService.CompositeType tmpvar = new myWCFService.CompositeType();
            tmpvar.StringValue = nametb.Text;
            tmpvar.BoolValue = true;

            myWCFService.Service1Client tmp = new myWCFService.Service1Client();
            myWCFService.CompositeType tmpout = tmp.GetDataUsingDataContract(tmpvar);
            outputlb.Text = tmpout.StringValue;
        }
    }
}