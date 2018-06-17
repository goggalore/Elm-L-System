this.onmessage = (e) => {
    console.log("Hello from path.js");
    
    if (e.data.model !== undefined && e.data.commands !== undefined) {
      this.postMessage(computePath(e.data.model, e.data.commands));
    }

    this.close();
}


function isLower(char) {  
    const charIndex = char.charCodeAt();
    
    if (charIndex >= 'a'.charCodeAt() && charIndex <= 'z'.charCodeAt()) {
      return true;
    }
    
    return false;
  }


function computePath (model, commands) {
    const radius = 1;
    const angle = model.angle;

    let position = {
      x: 0, 
      y: 0,
      action: 'moveTo'
    };
    let positionStack = []; 
    let path = [{x: position.x, y: position.y}];
    let char = '';

    let orientation = model.orientation;

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

