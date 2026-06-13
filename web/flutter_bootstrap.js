{{flutter_js}}
{{flutter_build_config}}

const loading = document.getElementById('splash-screen');

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    if (document.body.contains(loading)) {
      document.body.removeChild(loading);
    }
    await appRunner.runApp();
  }
});