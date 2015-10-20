var container, camera, scene, renderer, controls;

function initViewer(stlPath) {
  container = $(".viewer")[0]
  var width = container.clientWidth;
  var height = container.clientHeight;

  scene = new THREE.Scene();

  camera = new THREE.PerspectiveCamera(

          75,                                     // field of view in degrees?
          width/height,                         // canvas based aspect ratio; use when canvas is smaller than page
          0.1  ,                                   // distance to nearest side of rendered space
          10000                                   // distance to farthest side of rendered space
         );

  camera.position.set(400, 300, 500);
  camera.lookAt(scene.position);


  controls = new THREE.TrackballControls(camera , container);
  controls.addEventListener('change', render);

  // lights

  scene.add(new THREE.AmbientLight(0xFFFF00));
  var light = new THREE.PointLight(0xFFFF00);
  light.position.set(100, 0, 100);
  scene.add(light);

  // var directionalLight = new THREE.DirectionalLight(0xffffff, 9);
  // directionalLight.position = camera.position;
  // scene.add(directionalLight);

  // renderer

  renderer = new THREE.WebGLRenderer({ antialias: true });
  renderer.setSize(width , height);
  container.appendChild(renderer.domElement);

  // window.addEventListener('resize', onWindowResize, function);
}

function addLight(x, y, z, color, intensity) {

  var directionalLight = new THREE.DirectionalLight(color, intensity);
  directionalLight.position.set(x, y, z)
  scene.add(directionalLight);

}

function onWindowResize() {

  camera.aspect = width / height;
  camera.updateProjectionMatrix();

  renderer.setSize(width, height);
}

function animateViewer(stlPath) {
  var loader = new THREE.STLLoader();

  loader.load(stlPath, function(geometry) {
    // var geometry = event.content;

    var material = new THREE.MeshLambertMaterial({color: 0xe9b762});

    var mesh = new THREE.Mesh(geometry, material);
    scene.add(mesh);
  });
  requestAnimationFrame(animateViewer);
  controls.update();
  render();

}

function render() {

 camera.lookAt(scene.position);
 renderer.render(scene, camera);

}
