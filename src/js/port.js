import { getTransformations } from './canvas/transformations.js';
import { renderDrawing } from './canvas/draw.js';
import { renderAnimation, stopPreviousAnimation } from './canvas/animate.js';

const node = document.getElementById('elm');
const app = Elm.Main.embed(node);

app.ports.draw.subscribe((model) => {
    if (model.util.animate) {
        renderAnimation(getTransformations(model), model.util);
    }
    
    else {
        stopPreviousAnimation();
        renderDrawing(getTransformations(model), model.util);
    }
});