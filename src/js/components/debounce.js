export function debounce(func, delay) {
    let timer = null;
    return (() => {
        const context = this;
        const arg = arguments;
        
        clearTimeout(timer);
        timer = setTimeout((() => {
            func.apply(context, arg);
        }), delay)
    });
}