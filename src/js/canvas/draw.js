export function renderDrawing(transforms, options) {
    const canvas = document.getElementById('canvasMain');
    const context = canvas.getContext('2d');

    const path = transforms.path;
    const bounds = transforms.bounds;
    const scale = transforms.scale;
    const center = transforms.center;

    context.restore();
    context.clearRect(0, 0, canvas.width, canvas.height);

    context.save();
    context.beginPath();
    
    context.scale(scale, scale);
    context.translate(
        center['x']/scale - bounds.center['x'],
        center['y']/scale - bounds.center['y']);
            
    context.lineWidth = 1/scale;
    context.strokeStyle = options.stroke;

    for (var i = 0; i < path.length; i++) {
        if (path[i]['action'] === 'lineTo') {
            context.lineTo(path[i].x, path[i].y);
        }
        else {
            context.moveTo(path[i].x, path[i].y);
        }
    }
    context.stroke();
}