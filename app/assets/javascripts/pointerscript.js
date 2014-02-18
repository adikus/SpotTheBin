$(function(){
    $('#pointer').click(function(e){
        var imgPos = $(this).offset();

        $('#game_center_x').val(Math.round(e.pageX - imgPos.left));
        $('#game_center_y').val(Math.round(e.pageY - imgPos.top));
    });
});
