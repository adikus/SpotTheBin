canvas = {};

$(function(){
	canvas.img = $("#pointerimg")[0];
	canvas.ctx = $("#pointer")[0].getContext("2d");
	var realx = 2816;
	var realy = 2048;
    $('#pointer').click(function(e){
        var imgPos = $(this).offset();
        $('#game_center_x').val(Math.round(e.pageX - imgPos.left));
        $('#game_center_y').val(Math.round(e.pageY - imgPos.top));
        drawer();
    });
    var x = ($('#pointer').width());
    $('#pointer').height(parseInt(realy*x/realx));
    drawMap();
});

function drawMap(){
	canvas.ctx.drawImage(canvas.img,0,0,canvas.img.width, canvas.img.height,0,0,$('#pointer').width(),$('#pointer').height());
}

function drawer(){
	drawMap();
	canvas.ctx.beginPath();
	

	canvas.ctx.arc(parseInt($('#game_center_x').val()), parseInt($('#game_center_y').val()), parseInt($('#game_radius').val()*188.75), 0, Math.PI*2, true); 

	canvas.ctx.strokeStyle = '#003300';
	canvas.ctx.stroke();
	canvas.ctx.closePath();
}