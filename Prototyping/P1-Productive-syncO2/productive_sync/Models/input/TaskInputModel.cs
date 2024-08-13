using Microsoft.VisualBasic;

namespace productive_sync.Models;

public class TaskInputModel{

    int project_id;
    int task_list_id;
    int? workflow_status;
    string title;
    int? assignee_id;
    string? description;
    DateOnly? due_date;
    int? initial_estimate;
    
    // bool? is_private;
    DateOnly? start_date;

    public TaskInputModel(int project_id, int task_list_id, string title)
    {
        this.project_id = project_id;
        this.task_list_id = task_list_id;
        this.title = title;
    }

    public TaskInputModel(){}
}