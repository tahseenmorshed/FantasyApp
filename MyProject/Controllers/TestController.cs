using System;
using Microsoft.AspNetCore.Mvc;

namespace MyProject.Controllers
{
	[ApiController]
    [Route("[controller]")]
    public class TestController : Controller
	{
		public TestController()
		{
		}

		[HttpGet]
		public IActionResult GetTest()
		{
			string x = "Tahseen"; 
			return Ok(x); 
		}
	}
}

