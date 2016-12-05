class MessengerBotController < ActionController::Base

  def message(event, sender)
    first_name = sender.get_profile([:first_name])
    last_name = sender.get_profile([:last_name])
    gender = sender.get_profile([:gender])
    sender_id = event['sender']['id']
    passed_sender = sender


    if Player.where(sender_id: sender_id).empty?

      username = "backdoor_" + Devise.friendly_token.first(4)
      password = Devise.friendly_token.first(6)
      email = Devise.friendly_token.first(6) + "@gmail.com"
      if gender[:body]["gender"] == "male"
        bot_gender = "female"
      elsif gender[:body]["gender"] == "female"
        bot_gender = "male"
      else
        bot_gender = "female"
      end
      bot_name = HTTParty.get("http://uinames.com/api/?gender=#{bot_gender}").first[1]



      Player.create!(sender_id: sender_id, first_name: first_name[:body]["first_name"], last_name: last_name[:body]["last_name"], username: username, password: password, plain_password: password, email: email, bot_gender: bot_gender, bot_name: bot_name)
    end

    @player = Player.where(sender_id: sender_id).first

    unless @player.current_story_node.nil?
      dialogue(@player.current_story_node, sender_id, passed_sender)
    else
      sender.reply({
      "text":"#{sender_id} Will you help me, #{first_name[:body]["first_name"]} #{bot_gender}?",
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

    # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    #sender.reply({ text: "Reply: #{event['message']['text']} #{profile}" })

  end

  def postback(event, sender)

    payload = event["postback"]["payload"]
    sender_id = event['sender']['id']
    passed_sender = sender
    dialogue(payload, sender_id, passed_sender)

  end

  def dialogue(current_story_node, sender_id, sender)
    @player = Player.where(sender_id: sender_id).first

    case current_story_node

    when "HELP_YES"

      @player.current_story_node = "HELP_YES"
      @player.save!

      sender.reply({
      "text":"can you help me?",
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

      @player.current_story_node = "HELP_NO"
      @player.save!

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

  def delivery(event, sender)
  end

end
