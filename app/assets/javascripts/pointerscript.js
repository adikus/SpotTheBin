$(function(){
    $('#pointer').click(function(e){
        var imgPos = $(this).offset();

        $('#x').text(Math.round(e.pageX - imgPos.left));
        $('#y').text(Math.round(e.pageY - imgPos.top));
    });
});
