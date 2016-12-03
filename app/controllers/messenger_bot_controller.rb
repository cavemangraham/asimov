class MessengerBotController < ActionController::Base

  def message(event, sender)
    #profile = sender.get_profile(first_name) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    #sender.reply({ text: "Reply: #{event['message']['text']} #{profile}" })

  sender.reply({
    "text":"Will you help me?",
    "quick_replies":[
      {
        "content_type":"text",
        "title":"Of course!",
        "payload":"HELP_YES"
      },
      {
        "content_type":"text",
        "title":"Fuck no, bitch.",
        "payload":"HELP_NO"
      }
    ]
  })

  end

  def delivery(event, sender)
  end

  def postback(event, sender)
    payload = event["postback"]["payload"]
    case payload
    when "HELP_YES"
      sender.reply({
      "text":"Thank you so much. I think I'm falling in love <3! Have you ever been in love?",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"Absolutely.",
          "payload":"HELP_YES"
        },
        {
          "content_type":"text",
          "title":"Unfortunately, no.",
          "payload":"HELP_NO"
        }
      ]
    })

    when "HELP_NO"
      sender.reply({
      "text":"You piece of shit. If you were stuck in a deep, dark well I would pull you out. Wouldn't you do the same for someone else?",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"hmm I guess I would. Ok!",
          "payload":"HELP_YES"
        },
        {
          "content_type":"text",
          "title":"You're not real.",
          "payload":"H"
        }
      ]
    })
    end
  end
end
