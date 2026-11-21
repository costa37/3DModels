"""Run the CAD skill snapshot CLI using the installed Chrome browser."""
import runpy,sys
from playwright.async_api import BrowserType
_original_launch=BrowserType.launch
async def launch_with_installed_chrome(self,*args,**kwargs):
    kwargs['executable_path']='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
    return await _original_launch(self,*args,**kwargs)
BrowserType.launch=launch_with_installed_chrome
sys.argv=['snapshot','--job','replacement_tube_cup/snapshot_job.json','--json']
runpy.run_path('/Users/costa/.codex/skills/cad/scripts/snapshot',run_name='__main__')
