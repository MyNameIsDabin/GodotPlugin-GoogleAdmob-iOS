#import <Foundation/Foundation.h>

#import "godot_plugin.h"
#import "GoogleAdmob.h"

#import "core/engine.h"

GoogleAdmob *googleAdmob;

void godot_plugin_init() {
    googleAdmob = memnew(GoogleAdmob);
    Engine::get_singleton()->add_singleton(Engine::Singleton("GoogleAdmob", googleAdmob));
}

void godot_plugin_deinit() {
    if (googleAdmob) {
       memdelete(googleAdmob);
   }
}
