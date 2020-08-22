using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Http;

namespace WebApiAPP.Controllers
{
    public class HomeController : ApiController
    {
        public string Index()
        {
            return "OK";
        }

        [Route("File/{message}")]
        [HttpGet]
        public string Index([FromUri]string message)
        {
            //using (var client = new WebClient())
            //{
            //    //client.Credentials = new NetworkCredential(ftpUsername, ftpPassword);
            //    System.IO.File.WriteAllText("tmp.txt", message);
            //    client.UploadFile("ftp://localhost/outbox/webapioutput.txt", WebRequestMethods.Ftp.UploadFile, "tmp.txt");
            //}
            try
            {
                System.IO.File.WriteAllText(@"c:\tmp.txt", message);

                FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://localhost/webapioutput.txt");
                //request.Credentials = new NetworkCredential("username", "password");
                request.Method = WebRequestMethods.Ftp.UploadFile;

                using (Stream fileStream = File.OpenRead(@"c:\tmp.txt"))
                using (Stream ftpStream = request.GetRequestStream())
                {
                    fileStream.CopyTo(ftpStream);
                }
                return message;
            }
            catch(Exception e)
            {
                return e.Message;
            }
        }
    }
}
