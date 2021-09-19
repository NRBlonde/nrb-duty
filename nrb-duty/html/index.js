nrblonde = {}

$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    $("#nrblonde").click(function () {
        let inputValue = $("#nrblonde").val() 
        return;
    })
})

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            nrblonde.Close();
            break;
    }
});

nrblonde.Close = function() {
    $("#container").fadeOut(175);
    $.post('http://nrb-duty/close');
}

$("#mesaigir").click(function() {
    $.post('https://nrb-duty/Mesaigir', JSON.stringify({}));
});

$("#mesaicik").click(function() {
    $.post('https://nrb-duty/Mesaicik', JSON.stringify({}));
});