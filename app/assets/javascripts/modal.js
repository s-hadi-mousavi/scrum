
function submitTask(project_id) {

    console.log("Nothing")
    var input = $("#new-task-description").val()

    console.log(input)
    
    $.ajax({
        url: "/projects/addtask",
        type: "GET",
        data: 'project_id='+project_id+"&description="+input,
        success: function(data) {
            $("#new-task-description").val( "")
            $('.modal').modal('hide')
            $('#task-tab').append(data)
        },

    })
    //Submit
    return;
};
