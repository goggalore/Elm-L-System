export function getContext(canvas, transforms, options) {
    const context = canvas.getContext('2d');

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

    return context;
}