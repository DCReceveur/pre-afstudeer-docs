using System;
using System.Collections.Generic;
namespace productive_sync.Models;
public class ProductiveGetTasksModel
{
    public Data[]? Data { get; set; }
    public Meta? Meta { get; set; }
}

public class Data
{
    public string? Id { get; set; }
    public string? Type { get; set; }
    public Attributes? Attributes { get; set; }
    public Relationships? Relationships { get; set; }
}

public class Attributes
{
    public string? Title { get; set; }
    public string? Description { get; set; }
    public string? Number { get; set; }
    public string? TaskNumber { get; set; }
    public bool? Private { get; set; }
    public DateTime? DueDate { get; set; }
    public DateTime? StartDate { get; set; }
    public DateTime? ClosedAt { get; set; }
    public DateTime? CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public int? RepeatScheduleId { get; set; }
    public int? RepeatOnInterval { get; set; }
    public int? RepeatOnMonthday { get; set; }
    public List<string>? RepeatOnWeekday { get; set; }
    public DateTime? RepeatOnDate { get; set; }
    public int? RepeatOriginId { get; set; }
    public string? EmailKey { get; set; }
    public object? CustomFields { get; set; }
    public int? TodoCount { get; set; }
    public int? OpenTodoCount { get; set; }
    public int? SubtaskCount { get; set; }
    public int? OpenSubtaskCount { get; set; }
    public int CreationMethodId { get; set; }
    public List<int>? TodoAssigneeIds { get; set; }
    public int TaskDependencyCount { get; set; }
    public int TypeId { get; set; }
    public int BlockingDependencyCount { get; set; }
    public int WaitingOnDependencyCount { get; set; }
    public int LinkedDependencyCount { get; set; }
    public object? Placement { get; set; }
    public object? SubtaskPlacement { get; set; }
    public bool Closed { get; set; }
    public object? DueTime { get; set; }
    public List<string>? TagList { get; set; }
    public DateTime LastActivityAt { get; set; }
    public object? initial_estimate { get; set; }
    public object? RemainingTime { get; set; }
    public object? BillableTime { get; set; }
    public object? WorkedTime { get; set; }
    public DateTime? DeletedAt { get; set; }
}

public class Relationships
{
    public Organization? Organization { get; set; }
    public RelationshipMeta? Project { get; set; }
    public RelationshipMeta? Creator { get; set; }
    public RelationshipMeta? Assignee { get; set; }
    public RelationshipMeta? LastActor { get; set; }
    public RelationshipMeta? TaskList { get; set; }
    public RelationshipMeta? ParentTask { get; set; }
    public RelationshipMeta? WorkflowStatus { get; set; }
    public RelationshipMeta? RepeatedTask { get; set; }
    public RelationshipMeta? Attachments { get; set; }
    public RelationshipMeta? CustomFieldPeople { get; set; }
    public RelationshipMeta? CustomFieldAttachments { get; set; }
}

public class Organization
{
    public OrganizationData? Data { get; set; }
}

public class OrganizationData
{
    public string? Type { get; set; }
    public string? Id { get; set; }
}

public class RelationshipMeta
{
    public Meta? Meta { get; set; }
}

public class Meta
{
    public bool Included { get; set; }
}
