import { getTransformations } from './canvas/transformations.js';
import { renderDrawing } from './canvas/draw.js';
import { renderAnimation } from './canvas/animate.js';
import { renderTimedAnimation } from './canvas/timedAnimate.js';
import { stopAnimations } from './canvas/stop';

const node = document.getElementById('elm');
const app = Elm.Main.embed(node);

app.ports.draw.subscribe((model) => {
    const transforms = getTransformations(model);

    stopAnimations();

    if (model.util.animate) {
        renderAnimation(transforms, model.util);
    }
    
    else if (model.util.timed) {
        renderTimedAnimation(transforms, model.util, 4000);
    }

    else {
        renderDrawing(transforms, model.util);
    }
});

