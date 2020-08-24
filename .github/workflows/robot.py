# Thanks to github.com/usernein

import os
import pyrogram

with open('Aonly.txt') as f:
    os.environ['CAT_FILE'] = f.read()

rom = os.getenv('ROM_NAME')
zip = os.getenv('ZIP_NAME')
cat = os.getenv('CAT_FILE')
romurl = os.getenv('ROM_URL')
da = os.getenv('DOWNLOAD_A')
dab = os.getenv('DOWNLOAD_AB')
notes = os.getenv('NOTES')

with pyrogram.Client('bot', os.getenv('API_ID'), os.getenv('API_HASH'), bot_token=os.getenv('BOT_TOKEN')) as client:
    client.send_message(
        text=f"""<b>{zip} GSI For A/AB Devices</b>

<b>Firmware Base:</b> <a href="{romurl}">HERE</a>

<b>Information:</b>
<code>{cat}</code>

<b>Download A-Only:</b> <a href="{da}">HERE</a>
<b>Download AB:</b> <a href="{dab}">HERE</a>

<b>Notes: </b>"{notes}
<b>@amyGSI</b> - <i>Channel</i>: @amyGSI

<a href="https://github.com/amyGSI/ErfanGSIs">Ported using amyGSI's ErfanGSIs Edit</a>""",
        chat_id=os.getenv('CHAT_ID'),
        parse_mode="html",
        disable_web_page_preview=True
    )
