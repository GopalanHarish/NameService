using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;

namespace ConsoleApp
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                using (var client = new WebClient())
                {
                    StringBuilder output = new StringBuilder();
                    //Make sure file exist before running this exe otherwise 550 error.
                    output.AppendLine(client.DownloadString("ftp://localhost/consoleoutput.txt"));
                    output.AppendLine(DateTime.Now + " : " + client.DownloadString("ftp://localhost/webapioutput.txt") + "<br/>");
                    client.UploadString("ftp://localhost/consoleoutput.txt", WebRequestMethods.Ftp.UploadFile, output.ToString());
                    Console.WriteLine(output.ToString());
                }
            }catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}
