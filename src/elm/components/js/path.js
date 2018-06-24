function isLowerAlpha(char) {  
    const charIndex = char.charCodeAt();
    
    if (charIndex >= 'a'.charCodeAt() && charIndex <= 'z'.charCodeAt()) {
      return true;
    }
    
    return false;
  }

function computePath(data) {
    const radius = 1; 

    let position = {
      x: 0, 
      y: 0,
      action: 'moveTo'
    };
    let positionStack = []; 
    let path = [{x: position.x, y: position.y}];
    let char = '';
    
    let angle = data.angle * Math.PI / 180
    let orientation = data.orientation * Math.PI / 180;    
    let commands = data.commands;

    for (let i = 0; i < commands.length; i++) {
      char = commands[i];
      
      if (isLowerAlpha(char)) {
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

function computeBounds(path) {
    let xPos = [];
    let yPos = [];
    
    for (let i = 0; i < path.length; i++) {
      xPos.push(path[i].x);
      yPos.push(path[i].y);
    }
    
    let xMax = xPos.reduce(function(a, b) {
      return Math.max(a, b);
    });
    
    let yMax = yPos.reduce(function(a, b) {
      return Math.max(a, b);
    });
    
    let xMin = xPos.reduce(function(a, b) {
      return Math.min(a, b);
    });
    
    let yMin = yPos.reduce(function(a, b) {
      return Math.min(a, b);
    });
    
    let bounds = {
      xMin: xMin,
      xMax: xMax,
      yMin: yMin,
      yMax: yMax
    };
    
    let center = {
      x: (xMin + xMax)/2,
      y: (yMin + yMax)/2
    };
    
    bounds.center = center;
    
    return bounds;
                           
  }
  
  function computeScale(bounds, maxDimension) { 
    let scale = 1;
    let dimension = {
      width: bounds.xMax - bounds.xMin,
      height: bounds.yMax - bounds.yMin
    };
  
    if (maxDimension.width/dimension.width <=
        maxDimension.height/dimension.height) {
      scale = maxDimension.width / dimension.width;
    }
    else {
      scale = maxDimension.height / dimension.height;
    }
    
    return scale;
}

function renderStill(data) {
  const canvas = document.getElementById('canvasMain');
  const context = canvas.getContext('2d');

  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  const center = {x: canvas.width/2, y: canvas.height/2};
  const maxDimension = {width: canvas.width * 0.9, height: canvas.height * 0.9};

  console.log(maxDimension);

  const path = computePath(data);
  const bounds = computeBounds(path);
  const scale = computeScale(bounds, maxDimension);

  context.save();
  context.beginPath();
  
  context.scale(scale, scale);
  context.translate(center['x']/scale - bounds.center['x'],
                  center['y']/scale - bounds.center['y']);
  context.lineWidth = 1/scale;
  context.strokeStyle = 'black';
  
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