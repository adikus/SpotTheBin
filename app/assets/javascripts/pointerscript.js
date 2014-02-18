canvas = {};

$(window).load(function(){
	canvas.img = $("#pointerimg")[0];
	canvas.ctx = $("#pointer")[0].getContext("2d");
    canvas.$   = $('#pointer');

    canvas.$.click(function(e){
        var imgPos = $(this).offset();
        $('#game_center_x').val(Math.round((e.pageX - imgPos.left)/canvas.scale));
        $('#game_center_y').val(Math.round((e.pageY - imgPos.top)/canvas.scale));
        drawer();
    });

    canvas.width = canvas.$.parent().width();
    canvas.height = parseInt(canvas.img.height*canvas.width/canvas.img.width);
    canvas.$[0].width = canvas.width ;
    canvas.$[0].height = canvas.height;
    canvas.$.height(canvas.height);
    canvas.scale = canvas.width/canvas.img.width;
    drawMap();
});

function drawMap(){
	canvas.ctx.drawImage(canvas.img,0,0,canvas.img.width, canvas.img.height,0,0,canvas.width,canvas.height);
}

function drawer(){
	drawMap();
    var cX = parseInt($('#game_center_x').val()*canvas.scale);
    var cy = parseInt($('#game_center_y').val()*canvas.scale);
    var radius = $('#game_radius').val();

	canvas.ctx.beginPath();
	canvas.ctx.arc(cX, cy, parseInt(radius*377.5*canvas.scale), 0, Math.PI*2, true);
    canvas.ctx.lineWidth=2;
    canvas.ctx.strokeStyle = '#3366FF';
    canvas.ctx.fillStyle = 'rgba(51,102,255,0.1)';
	canvas.ctx.stroke();
    canvas.ctx.fill();
	canvas.ctx.closePath();
}