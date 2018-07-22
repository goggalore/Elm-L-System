import { getTransformations } from './canvas/transformations.js';
import { renderDrawing } from './canvas/draw.js';
import { renderAnimation } from './canvas/animate.js';
import { renderTimedAnimation } from './canvas/timedAnimate.js';
import { stopAnimations } from './canvas/stop';
import { debounce } from "./components/debounce";

const node = document.getElementById('elm');
const app = Elm.Main.embed(node);

app.ports.draw.subscribe((model) => {
    const render = () => {
        stopAnimations();
        const transforms = getTransformations(model);

        if (model.util.animate) {
            renderAnimation(transforms, model.util);
        }
        
        else if (model.util.timed) {
            renderTimedAnimation(transforms, model.util, 4000);
        }

        else {
            renderDrawing(transforms, model.util);
        }
    }
    
    window.onresize = debounce(render, 100);
    render();
});

