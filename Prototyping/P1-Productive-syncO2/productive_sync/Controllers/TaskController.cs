using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Mvc;
using productive_sync.Models;
using RouteAttribute = Microsoft.AspNetCore.Mvc.RouteAttribute;

namespace productive_sync.Controllers;


[Route("/")]
[ApiController]
public class TaskController : ControllerBase
{
    // [HttpGet("ep_path")]
    // [AllowAnonymous]
    // public String testEndpoint(){
    //     return "ello";
    // }

    [AllowAnonymous]
    [HttpPost]
    public ProductiveGetTaskModel AddTask([FromBody] ProductiveGetTaskModel inputModel){
        Console.WriteLine("thing");
        return inputModel;
    }

    // [HttpPost("addMultiple")]
    // public ProductiveGetTasksModel AddTasks([FromBody] ProductiveGetTasksModel inputModel){
    //     Console.WriteLine("thing");
    //     return inputModel;
    // }

    // [HttpGet("get")]
    // public ProductiveGetTaskModel GetTasks(){

    // }
}