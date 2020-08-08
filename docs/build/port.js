(function () {
'use strict';

function computeCommands(model) {
    const rules = arrayToObject(model.rules);
    const maxLength = 200000;

    let result = model.axiom.split('');

    for (let i = 0; i < model.iterations; i++) {
        if (result.length > maxLength) {
            break;
        }

        result = result.map((char) => {
            if (rules[char] === undefined) {
                return char;
            }
            
            return rules[char];
        }).join('').split('');
    }

    return result;
}

function arrayToObject(array) {
    const result = {};

    for (let i = 0; i < array.length; i++) {
        result[array[i][0]] = array[i][1];
    }

    return result;
}

function computePath (model, commands) {
	const radius = 1;
	const angle = model.angle * Math.PI / 180;

	let position = {
        x: 0, 
        y: 0,
        action: 'moveTo'
	};
	let positionStack = []; 
	let path = [{x: position.x, y: position.y}];
	let char = '';

	let orientation = model.orientation * Math.PI / 180;

	for (let i = 0; i < commands.length; i++) {
		char = commands[i];

		if (isLower(char)) {
			path.push({x: position.x, y: position.y, action: 'lineTo'});
		}

		else {
			switch(char) {
			case '+':
				orientation += angle;
				break;
			case '-': 
			case '−':
				orientation -= angle;
				break;
			case '[':
				positionStack.push({x: position.x, y: position.y, orientation: orientation});
				break;
			case ']':
				let temp = positionStack.pop();
				position.x = temp.x;
				position.y = temp.y;
				orientation = temp.orientation;
				path.push({x: position.x, y: position.y, action: 'moveTo'});
				break;
			default:
				position.x += radius * Math.cos(orientation); 
				position.y -= radius * Math.sin(orientation);
				path.push({x: position.x, y: position.y, action: 'lineTo'});
				break;
			}
		}
	}
  
	return path;
}

function isLower(char) {  
	const charIndex = char.charCodeAt();

	if (charIndex >= 'a'.charCodeAt() && charIndex <= 'z'.charCodeAt()) {
		return true;
	}

	return false;
}

function computeBounds(path) {
    let xPos = [];
    let yPos = [];
    
    for (let i = 0; i < path.length; i++) {
        xPos.push(path[i].x);
        yPos.push(path[i].y);
    }
    
    const xMax = xPos.reduce(function(a, b) {
        return Math.max(a, b);
    });
    
    const yMax = yPos.reduce(function(a, b) {
        return Math.max(a, b);
    });
    
    const xMin = xPos.reduce(function(a, b) {
        return Math.min(a, b);
    });
    
    const yMin = yPos.reduce(function(a, b) {
        return Math.min(a, b);
    });
    
    const bounds = {
        xMin: xMin,
        xMax: xMax,
        yMin: yMin,
        yMax: yMax
    };
    
    const center = {
        x: (xMin + xMax)/2,
        y: (yMin + yMax)/2
    };
    
    bounds['center'] = center;
    
    return bounds;
}

function computeScale(bounds, maxDimension) {
    let scale = 1;

    const dimension = {
        width: bounds.xMax - bounds.xMin,
        height: bounds.yMax - bounds.yMin
    };

    if (maxDimension.width/dimension.width <= maxDimension.height/dimension.height) {
        scale = maxDimension.width / dimension.width;
    }
    else {
        scale = maxDimension.height / dimension.height;
    }

    return scale;
}

function getTransformations(model) {
    const canvas = document.getElementById('canvasMain');

    canvas.width = 2000;
    canvas.height = 2000;

    const center = {
        x: canvas.width / 2,
        y: canvas.height / 2
    };

    const maxDimension = {
        width: canvas.width * 0.90,
        height: canvas.height * 0.90
    };

    const commands = computeCommands(model);
    const path = computePath(model, commands);
    const bounds = computeBounds(path);
    const scale = computeScale(bounds, maxDimension);

    return {
        path: path,
        bounds: bounds,
        scale: scale,
        center: center
    }
}

function getContext(canvas, transforms, options) {
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

function renderDrawing(transforms, options) {
    const canvas = document.getElementById('canvasMain');
    const context = getContext(canvas, transforms, options);
    const path = transforms.path;

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

let prev = undefined;

function renderAnimation(transforms, options) {
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
    };
    
    animate();
}

function stopPreviousAnimation() {
    if (prev) {
        window.cancelAnimationFrame(prev);
    }
}

let prev$1 = undefined;

function renderTimedAnimation(transforms, options, ms) {
    const canvas = document.getElementById('canvasMain');
    const context = getContext(canvas, transforms, options);

    const path = transforms.path;
    const fps = 60;
    const steps = Math.floor(path.length / (fps * (ms/1000))) || 1;

    let i = 0;
    const animate = () => 
    {
        if (i * steps < path.length - 1) {
            prev$1 = window.requestAnimationFrame(animate);
        }

        else {
            renderDrawing(transforms, options);
        }

        for (let l = steps * i; l < steps * i + steps; l++) {
            if (path[l] === undefined) {
                break;
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
    };

    animate();
}

function stopPreviousTimedAnimation() {
    if (prev$1) {
        window.cancelAnimationFrame(prev$1);
    }
}

function stopAnimations() {
    stopPreviousAnimation();
    stopPreviousTimedAnimation();
}

function debounce(func, delay) {
    let timer = null;
    return (() => {
        const context = this;
        const arg = arguments;
        
        clearTimeout(timer);
        timer = setTimeout((() => {
            func.apply(context, arg);
        }), delay);
    });
}

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
    };
    
    window.onresize = debounce(render, 100);
    render();
});

}());
