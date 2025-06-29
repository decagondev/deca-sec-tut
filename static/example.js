const query = new URLSearchParams(window.location.search).get('q');
if (query) {
    document.getElementById('result').innerHTML = query;
}

window.config = { data: 'secret' };
if (window.config) {
    console.log(window.config.data);
}

function loadData(callback) {
    const script = document.createElement('script');
    script.src = `/data?callback=${callback}`;
    document.body.appendChild(script);
}

function merge(target, source) {
    for (const key in source) {
        target[key] = source[key];
    }
}
