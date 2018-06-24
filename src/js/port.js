import { renderDrawing } from './canvas/draw.js';

const node = document.getElementById('elm');
const app = Elm.Main.embed(node);

app.ports.draw.subscribe((model) => {
    renderDrawing(model)
});