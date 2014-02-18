$(function(){
    $('#pointer').click(function(e){
        var imgPos = $(this).offset();

        $('#x').text(Math.round(e.pageX - imgPos.left));
        $('#y').text(Math.round(e.pageY - imgPos.top));
    });
});

var c=document.getElementById("myCanvas");
var ctx=c.getContext("2d");

function draw(){
	
	//ctx.fillStyle="#FF0000";
	//ctx.fillRect(10,10,150,80);
}