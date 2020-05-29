#include "pch.h"

#include <vcpkg/globalstate.h>

namespace vcpkg
{
    Util::LockGuarded<Chrono::ElapsedTimer> GlobalState::timer;
    Util::LockGuarded<std::string> GlobalState::g_surveydate;

    std::atomic<bool> GlobalState::g_binary_caching(false);
    std::atomic<bool> GlobalState::g_compiler_tracking(false);

    std::atomic<int> GlobalState::g_init_console_cp(0);
    std::atomic<int> GlobalState::g_init_console_output_cp(0);
    std::atomic<bool> GlobalState::g_init_console_initialized(false);
}
