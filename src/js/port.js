import { loadWorker } from './workers/workers.js';

const node = document.getElementById('elm');
const app = Elm.Main.embed(node);

app.ports.draw.subscribe((model) => {
    if (window.Worker) {
        loadWorker(model, './workers/commands.js').then((commands) => {
            loadWorker({model: model, commands: commands.data }, '../src/js/workers/path.js').then((path) => {
                if (path.data instanceof Array) {
                    // draw
                    console.log(path.data);
                }

                else {
                    console.warn(`Could not draw from data ${path.data}`);
                }
            }).catch((error) => {
                console.warn(error)
            });
        }).catch((error) => {
            console.warn(error)
        });
    }
}); 