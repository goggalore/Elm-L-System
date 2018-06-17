export const loadWorker = (data, path) => {
    return new Promise((resolve, reject) => {
        const worker = new Worker(path);

        worker.postMessage(data);

        worker.onmessage = (e) => {
            resolve(e);
        }

        worker.onerror = () => {
            const message = `Something went wrong with the worker with file ${path}`
            worker.terminate();
            reject(new Error(message));
        }
    });
}