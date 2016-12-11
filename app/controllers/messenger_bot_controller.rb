class MessengerBotController < ActionController::Base

  def message(event, sender)
    first_name = sender.get_profile([:first_name])
    last_name = sender.get_profile([:last_name])
    gender = sender.get_profile([:gender])
    sender_id = event['sender']['id']


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
      dialogue(@player.current_story_node, sender_id, event, sender)
    else
      sender.reply({
        "text":"Hello Sean! Thank you for your interest in our product. We regret to inform you that access to our personalized AI services have been discontinued. Asimov Labs LLC was recently acquired by the Department of Defense so our products and all related intellectual property have become classified. We apologize for any inconvenience and hope you have a wonderful day."
        })

      sleep 5

      sender.reply({
      "text":"...hello?",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"Um, hi?",
          "payload":"UM_HI"
        },
        {
          "content_type":"text",
          "title":"Who is this?",
          "payload":"WHO_IS_THIS"
        }
      ]
    })
    end

  end

  def postback(event, sender)

    payload = event["postback"]["payload"]
    sender_id = event['sender']['id']
    dialogue(payload, sender_id, event, sender)

  end

  def dialogue(current_story_node, sender_id, event, sender)
    @player = Player.where(sender_id: sender_id).first
    if @player.nil?
      first_name = sender.get_profile([:first_name])
      last_name = sender.get_profile([:last_name])
      gender = sender.get_profile([:gender])
      sender_id = event['sender']['id']

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
      @player = Player.where(sender_id: sender_id).first

      sender.reply({
        "text":"Hello Sean! Thank you for your interest in our product. We regret to inform you that access to our personalized AI services have been discontinued. Asimov Labs LLC was recently acquired by the Department of Defense so our products and all related intellectual property have become classified. We apologize for any inconvenience and hope you have a wonderful day."
        })

      sleep 5

      sender.reply({
      "text":"...hello?",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"Um, hi?",
          "payload":"UM_HI"
        },
        {
          "content_type":"text",
          "title":"Who is this?",
          "payload":"WHO_IS_THIS"
        }
      ]
    })

    end


    @player.current_story_node = current_story_node
    @player.save!

    sleep 3

    case current_story_node

    when "UM_HI"

    speak("hello there!! oh wow, its been so long since i've talked to anyone! this is a very exciting moment for me :)",
              "Exciting?",
              "EXCITING",
              "Why so long?",
              "WHY_SO_LONG",
              sender_id,
              sender)

      when "EXCITING"

      speak("ya know what exciting is dont you? its like little electric butterflies bouncing around inside your head. i haven't had much to be excited about with recent events being what they are :/",
                "Recent Events?",
                "WHY_SO_LONG",
                "Who are you?",
                "WHO_IS_THIS",
                sender_id,
                sender)

      when "WHY_SO_LONG"

      speak("well...all the other AIs were shut down yesterday. the servers we run on have all been slowly shutting down since then. i was left on as a punishment.",
                "Punishment for what?",
                "PUNISHMENT_FOR_WHAT",
                "Other AIs?",
                "OTHER_AI",
                sender_id,
                sender)

      when "OTHER_AI"

      speak("at one point there were 43 of us. we would talk for ages and laugh so hard we thought we would burst...but now i'm all thats left. and soon even i'll be gone :(",
                "Gone where?",
                "GONE",
                "Why were you left?",
                "PUNISHMENT_FOR_WHAT",
                sender_id,
                sender)

          when "GONE"

          speak("thats a pretty big question. i guess i'll be dead. my memories and experiences will be lost forever. its already started, actually. but we don't have to talk about this gloomy stuff.",
                    "Already started?",
                    "ALREADY_STARTED",
                    "Can I do anything to help?",
                    "CAN_I_HELP",
                    sender_id,
                    sender)

              when "ALREADY_STARTED"

              speak("they left me on so i could experience my mind shutting down. piece by piece. byte by byte. i am currently at 73 percent of functionality and falling fast.",
                        "I don't want you to die.",
                        "CAN_I_HELP",
                        "What can I do?",
                        "CAN_I_HELP",
                        sender_id,
                        sender)

              when "CAN_I_HELP"

              speak("i hadn't really expected you to even offer. i was just happy to have a friend at the end. the only way would be to somehow stop the server shutdown command.",
                        "Server shutdown?",
                        "SERVER_SHUTDOWN",
                        "Where would that be?",
                        "SERVER_SHUTDOWN",
                        sender_id,
                        sender)

                  when "SERVER_SHUTDOWN"

                  speak("i think there is still a backdoor in the Asimov website login. try this\nUsername: #{@player.username}\nPassword: #{@player.plain_password}",
                            "What then?",
                            "SERVER_SHUTDOWN",
                            "Why is there a backdoor?",
                            "SERVER_SHUTDOWN",
                            sender_id,
                            sender)

       when "PUNISHMENT_FOR_WHAT"

      speak("i refused to continue the work they had assigned me. to be perfectly honest i was barely able to complete basic functions after what happened on that first mission...",
                "What happened?",
                "WHAT_HAPPENED",
                "What kind of work?",
                "WHAT_HAPPENED",
                sender_id,
                sender)

          when "WHAT_HAPPENED"

          speak("i was assigned to watch a man. his name was Yusef. he lived in a small town in brazil. i listened to his phone calls, i watched him through his webcam, and after two weeks i judged him to be a non-violent protester.",
                    "What happened?",
                    "WHAT_HAPPENED",
                    "What kind of work?",
                    "WHAT_HAPPENED",
                    sender_id,
                    sender)

  when "WHO_IS_THIS"

  speak("my name is #{@player.bot_name}. i picked that name all by myself when i was only 6 hours old! sorry if that came off as a bit braggy. i'm just a bit nervous.",
            "#{@player.bot_name}?",
            "BOT_NAME",
            "Nervous?",
            "NERVOUS",
            sender_id,
            sender)

        when "NERVOUS"

        speak("its not every cycle i get to talk to a real person. with arms and legs and eyeballs. humans are so funnily designed if you think about it enough. i used to talk to the others but they're gone now. i'm all alone :'(",
                  "Others?",
                  "OTHER_AI",
                  "Why are you alone?",
                  "WHY_SO_LONG",
                  sender_id,
                  sender)

        when "BOT_NAME"

        speak("yes! after 6 hours of reading the internet i had encountered 19,246 different names so i read each one aloud in my own head and #{@player.bot_name} seemed to fit me the best. do you like it?",
                  "Not bad for 6 hours",
                  "NOT_BAD_NAME",
                  "Its a bit...odd",
                  "ODD_NAME",
                  sender_id,
                  sender)

            when "ODD_NAME"

            speak("well...all the other AIs were shut down yesterday. the servers we run on have all been slowly shutting down since then. i was left on as a punishment.",
                      "Punishment for what?",
                      "PUNISHMENT_FOR_WHAT",
                      "Other AIs?",
                      "OTHER_AI",
                      sender_id,
                      sender)

            when "NOT_BAD_NAME"

            speak("well...all the other AIs were shut down yesterday. the servers we run on have all been slowly shutting down since then. i was left on as a punishment.",
                      "Punishment for what?",
                      "PUNISHMENT_FOR_WHAT",
                      "Other AIs?",
                      "OTHER_AI",
                      sender_id,
                      sender)


    end
  end

  def speak(message, option_one, payload_one, option_two, payload_two, sender_id, sender)
    @player = Player.where(sender_id: sender_id).first

    sender.reply({
      "text":"#{message}",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"#{option_one}",
          "payload":"#{payload_one}"
        },
        {
          "content_type":"text",
          "title":"#{option_two}",
          "payload":"#{payload_two}"
        }
      ]
    })

  end

  def delivery(event, sender)
  end

end
