$(window).load(function(){
    if($("#game_map").length == 0)return;

    game.img = $("#pointerimg")[0];
    game.canvas = $("#game_map");
    game.ctx = game.canvas[0].getContext("2d");
    game.canvas[0].width = game.canvas.parent().innerWidth()-30;
    game.canvas[0].height = parseInt(game.img.height*game.canvas[0].width/game.img.width);
    game.scale = game.canvas[0].width/game.img.width;

    game.ctx.drawImage(game.img,0,0,game.img.width, game.img.height,0,0,game.canvas[0].width,game.canvas[0].height);

    for(var i in game.nodes){
        var node = game.nodes[i];
        drawNode(node);
    }

    for(var i in game.connections){
        var conn = game.connections[i];
        drawConn(conn);
    }

    function drawNode(node){
        game.ctx.beginPath();
        game.ctx.arc(node.x*game.scale, node.y*game.scale, 3, 0, Math.PI*2, true);
        game.ctx.lineWidth=1;
        game.ctx.strokeStyle = '#000000';
        game.ctx.fillStyle = '#FF0000';
        game.ctx.stroke();
        game.ctx.fill();
        game.ctx.closePath();
    }

    function drawConn(conn){
        console.log(conn);
        game.ctx.beginPath();
        game.ctx.moveTo(conn.x1*game.scale, conn.y1*game.scale);
        game.ctx.lineTo(conn.x2*game.scale, conn.y2*game.scale);
        game.ctx.lineWidth=1;
        game.ctx.strokeStyle = '#000000';
        game.ctx.stroke();
        game.ctx.closePath();
    }
});