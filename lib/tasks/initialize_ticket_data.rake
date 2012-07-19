namespace :db do
  task :initialize_ticket_data => :environment do
    Priority.create!([{
      :level => 1, :name => 'High', :description => 'VERY important, demands immediate attention.'
    },{
      :level => 5, :name => 'Medium', :description => 'Somewhat important, needs short-term attention.'
    },{
      :level => 10, :name => 'Low', :description => 'Non-critical, no rush.'
    }])
    TicketCategory.create!([{
      :name => 'SPA'
    }])
    TicketCode.create!([{
      :name => 'initialize',
      :past_name => 'initialized',
      :verb => 'with',
      :description => 'Just created.',
      :rank => 1,
      :color => '#000',
      :sender => true,
      :receiver => false
    },{
      :name => 'receive',
      :past_name => 'received',
      :verb => 'from',
      :description => 'Received.',
      :rank => 5,
      :color => '#999',
      :sender => false,
      :receiver => true
    },{
      :name => 'transfer',
      :past_name => 'transferred',
      :description => 'Transferred to another user.',
      :rank => 25,
      :color => '#999',
      :sender => true,
      :receiver => true
    },{
      :name => 'pending',
      :past_name => 'pending',
      :description => 'Ticket is being addressed.',
      :rank => 25,
      :color => '#999',
      :sender => false,
      :receiver => true
    },{
      :name => 'complete',
      :past_name => 'completed',
      :description => 'All associated requests finished. Ready for closure.',
      :rank => 25,
      :color => '#999',
      :sender => false,
      :receiver => true
    },{
      :name => 'close',
      :past_name => 'closed',
      :description => 'Completed & satisfied.',
      :rank => 25,
      :color => '#999',
      :sender => true,
      :receiver => false
    },{
      :name => 'incomplete',
      :past_name => 'incompleted',
      :description => 'Not yet addressed, or lacking information.',
      :rank => 25,
      :color => '#999',
      :sender => true,
      :receiver => true
    }])
  end
end
