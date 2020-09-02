import 'dart:io';

import 'package:flutter/material.dart';

const replaceString = '//<TO-BE-REPLACED>';

class HtmlGenerator {
  String template;
  String url;

  HtmlGenerator({this.template, @required this.url}) {
    generate();
  }

  File get _localFile {
    final path = template;
    return new File('assets/template/index.html');
  }

  void generate() {
    final file = _localFile;

    final html = StringBuffer(template);
    String script = '';
    setupVars(script);
    setupVars(script);
    setupStatsAndCamera(script);
    setupControls(script);
    setupLight(script);
    setupLoaders(script);
    loadModels(script);
    setupResizeProps(script);
    setupAnimations(script);
    script += ('</script></body></html>');
    html.write(script);
    // Write the file.
    file.writeAsString(html.toString());
  }

  void setupImports(String script) {
    script +=
        ('import * as THREE from "./node_modules/three/build/three.module.js";import Stats from "./node_modules/three/examples/jsm/libs/stats.module.js";import { OrbitControls } from "./node_modules/three/examples/jsm/controls/OrbitControls.js";import { GLTFLoader } from "./node_modules/three/examples/jsm/loaders/GLTFLoader.js";import { DRACOLoader } from "./node_modules/three/examples/jsm/loaders/DRACOLoader.js";');
  }

  void setupVars(String script) {
    script +=
        ('var scene, camera, dirLight, stats;var renderer, mixer, controls;var clock = new THREE.Clock();var container = document.getElementById("container");');
  }

  void setupStatsAndCamera(String script) {
    script +=
        ('stats = new Stats();container.appendChild(stats.dom);renderer = new THREE.WebGLRenderer({ antialias: true });renderer.setPixelRatio(window.devicePixelRatio);renderer.setSize(window.innerWidth, window.innerHeight);renderer.outputEncoding = THREE.sRGBEncoding;container.appendChild(renderer.domElement);scene = new THREE.Scene();scene.background = new THREE.Color(0xbfe3dd);camera = new THREE.PerspectiveCamera(40,window.innerWidth / window.innerHeight,1,100);camera.position.set(5, 2, 8);');
  }

  void setupControls(String script) {
    script +=
        ('controls = new OrbitControls(camera, renderer.domElement);controls.target.set(0, 0.5, 0);controls.update();controls.enablePan = false;controls.enableDamping = true;');
  }

  void setupLight(String script) {
    script +=
        ('scene.add(new THREE.HemisphereLight(0xffffff, 0x000000, 0.4));dirLight = new THREE.DirectionalLight(0xffffff, 1);dirLight.position.set(5, 2, 8);scene.add(dirLight);');
  }

  void setupLoaders(String script) {
    script +=
        ('var dracoLoader = new DRACOLoader();dracoLoader.setDecoderPath("node_modules/three/examples/js/libs/draco/gltf/");var loader = new GLTFLoader();loader.setDRACOLoader(dracoLoader);');
  }

  void loadModels(String script) {
    script += ('loader.load(');
    script += ("'$url'");
    script +=
        (',function (gltf) {var model = gltf.scene;model.position.set(1, 1, 0);model.scale.set(0.01, 0.01, 0.01);scene.add(model);mixer = new THREE.AnimationMixer(model);mixer.clipAction(gltf.animations[0]).play();animate();},undefined,function (e) {console.error(e);});');
  }

  void setupResizeProps(String script) {
    script +=
        ('window.onresize = function () {camera.aspect = window.innerWidth / window.innerHeight;camera.updateProjectionMatrix();renderer.setSize(window.innerWidth, window.innerHeight);};');
  }

  void setupAnimations(String script) {
    script +=
        ('function animate() {requestAnimationFrame(animate);var delta = clock.getDelta();mixer.update(delta);controls.update();stats.update();renderer.render(scene, camera);}');
  }
}
