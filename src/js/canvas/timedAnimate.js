import { renderDrawing } from './draw.js';
import { getContext } from './context.js';

let prev = undefined;

export function renderTimedAnimation(transforms, options, ms) {
    const canvas = document.getElementById('canvasMain');
    const context = getContext(canvas, transforms, options);

    const path = transforms.path;
    const fps = 60;
    const steps = Math.floor(path.length / (fps * (ms/1000)));

    let i = 0;
    const animate = () => 
    {
        if (i * steps < path.length - 1) {
            prev = window.requestAnimationFrame(animate);
        }

        else {
            renderDrawing(transforms, options);
        }

        for (let l = steps * i; l < steps * i + steps; l++) {
            if (path[l] === undefined) {
                i++;
                return;
            }

            if (path[l]['action'] === 'lineTo') {
                context.lineTo(path[l].x, path[l].y);
            }
            else {
                context.moveTo(path[l].x, path[l].y);
            }
        }

        context.stroke();
        i += 1;
    }

    animate();
}

export function stopPreviousTimedAnimation() {
    if (prev) {
        window.cancelAnimationFrame(prev);
    }
}

