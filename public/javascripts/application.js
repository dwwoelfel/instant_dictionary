jQuery.ajaxSetup({
    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
    $("#search_form").submit(function(event) {
        event.preventDefault();
        $.get($(this).attr("action"), $(this).serialize(), null, "script")
    });

    $("input#word").autocomplete({
        source: '/wordnik/search'
    });
});