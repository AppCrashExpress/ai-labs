import os
import subprocess
import telebot

class PrologDaemon:
	def __init__(self):
		self.p = None

	def is_running(self):
		return self.p is not None and self.p.poll() is None	

	def start(self):
		self.p = subprocess.Popen(['swipl', '../expert/ui.pl', '-O'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, bufsize=1, universal_newlines=True)
		out = self.p.stdout.readline()
		out = out + self.p.stdout.readline()
		return out

	def reset(self):
		if self.is_running():
			self.p.kill()
		self.start()	

	def update(self, ans):
		self.p.stdin.write(ans + '\n')
		return self.p.stdout.readline()


token = os.environ.get('BOT_TOKEN')
base = PrologDaemon()
bot = telebot.TeleBot(token)
markup = telebot.types.ReplyKeyboardMarkup()
yes_button = telebot.types.KeyboardButton('Да')
no_button = telebot.types.KeyboardButton('Нет')
markup.add(yes_button, no_button)

@bot.message_handler(commands=['start'])
def start(message):
    base.start()
    bot.reply_to(message, base.start(), reply_markup=markup)

@bot.message_handler(commands=['restart'])
def restart(message):
	if base.is_running():
		base.reset()
	else:
		bot.reply_to(message, 'Поиск не был начат или был закончен, чтобы начать напишите /start')

@bot.message_handler(commands=['help'])
def help(message):
    bot.reply_to(message, '/start - начать поиск\n/reset - перезапустить поиск\n/help - информация о командах')

@bot.message_handler(func=lambda message: True)
def handle_answer(message):
	if base.is_running():
		if message.text.lower() in ['да', 'ага', 'д', 'yes', 'yeah', 'sure', 'yep']:
			bot.reply_to(message, base.update('yes'), reply_markup=markup)
		else:
			bot.reply_to(message, base.update('no'), reply_markup=markup)	
	else:
		bot.reply_to(message, 'Поиск не был начат или был закончен, чтобы начать напишите /start')
		
bot.polling()