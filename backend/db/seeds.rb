# frozen_string_literal: true

Position.find_or_create_by(id: 1, name: 'Forward', short_name: 'FW')
Position.find_or_create_by(id: 2, name: 'Midfielder', short_name: 'MF')
Position.find_or_create_by(id: 3, name: 'Defender', short_name: 'DF')
Position.find_or_create_by(id: 4, name: 'Goalkeeper', short_name: 'GK')
