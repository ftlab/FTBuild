using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FTCab.Sample
{
    class Program
    {
        static void Main(string[] args)
        {
            var fi = new FileInfo("PackCab.ps1");
            var e = fi.Exists;
        }
    }
}
