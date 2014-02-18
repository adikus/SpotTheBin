$(function(){
    $('#pointer').click(function(e){
        var imgPos = $(this).offset();

        $('#game_center_x').val(Math.round(e.pageX - imgPos.left));
        $('#game_center_y').val(Math.round(e.pageY - imgPos.top));
    });
});

var c=document.getElementById("myCanvas");
var ctx=c.getContext("2d");

function draw(){
	
	//ctx.fillStyle="#FF0000";
	//ctx.fillRect(10,10,150,80);
}
