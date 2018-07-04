import { renderDrawing } from './draw.js';
import { getContext } from './context.js';

let prev = undefined;

export function renderAnimation(transforms, options) {
    const canvas = document.getElementById('canvasMain');
    const context = getContext(canvas, transforms, options);
    const path = transforms.path;

    let i = 0;
    const animate = () => 
    {
        if (i < path.length - 1) {
            prev = window.requestAnimationFrame(animate);
        }

        else {
            renderDrawing(transforms, options);
        }

        if (path[i]['action'] === 'lineTo') {
            context.lineTo(path[i].x, path[i].y);
        }
        else {
            context.moveTo(path[i].x, path[i].y);
        }

        context.stroke();
        i += 1;
    }
    
    stopPreviousAnimation();
    animate();
}

export function stopPreviousAnimation() {
    if (prev) {
        window.cancelAnimationFrame(prev);
    }
}
