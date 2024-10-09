# Tạo danh mục
categories = Category.create([
  { title: 'Technology', description: 'All about technology and gadgets.' },
  { title: 'Health', description: 'Health tips and wellness advice.' },
  { title: 'Travel', description: 'Travel guides and destination tips.' },
  { title: 'Food', description: 'Recipes, food reviews, and cooking tips.' },
  { title: 'Education', description: 'Learning resources and educational tips.' },
  { title: 'Business', description: 'Business strategies and tips.' },
  { title: 'Science', description: 'Scientific research and discoveries.' },
  { title: 'Lifestyle', description: 'Everything related to daily living.' },
  { title: 'Sports', description: 'Updates on various sports and events.' },
  { title: 'Music', description: 'Music news, trends, and reviews.' },
  { title: 'Movies', description: 'Movie reviews, news, and trailers.' },
  { title: 'Fashion', description: 'Latest trends in the fashion world.' },
  { title: 'Books', description: 'Book reviews and recommendations.' },
  { title: 'Gaming', description: 'Video games, reviews, and updates.' },
  { title: 'Finance', description: 'Financial advice and investment tips.' },
  { title: 'Marketing', description: 'Digital marketing strategies and tools.' },
  { title: 'Art', description: 'Art exhibitions, artists, and trends.' },
  { title: 'Photography', description: 'Tips and tricks for photographers.' },
  { title: 'Architecture', description: 'Design and architecture inspiration.' },
  { title: 'History', description: 'Historical events and their significance.' },
  { title: 'Politics', description: 'Political news and analysis.' },
  { title: 'Automotive', description: 'Car reviews and automotive industry news.' },
  { title: 'Real Estate', description: 'Property market trends and tips.' },
  { title: 'Environment', description: 'Environmental issues and conservation.' },
  { title: 'Parenting', description: 'Tips and advice for parents.' },
  { title: 'Pets', description: 'Everything about pets and pet care.' },
  { title: 'Fitness', description: 'Workout tips and fitness plans.' },
  { title: 'Mental Health', description: 'Resources and advice for mental well-being.' },
  { title: 'Technology Reviews', description: 'In-depth reviews of the latest tech.' },
  { title: 'Startups', description: 'News and advice for startup entrepreneurs.' },
  { title: 'Travel Tips', description: 'Travel hacks and budget-friendly tips.' },
  { title: 'Luxury', description: 'Luxury lifestyle and products.' },
  { title: 'Sustainability', description: 'Sustainable living tips and trends.' },
  { title: 'Entrepreneurship', description: 'Guidance for aspiring entrepreneurs.' },
  { title: 'Self-Improvement', description: 'Personal growth and development.' },
  { title: 'Cooking', description: 'Recipes and cooking tutorials.' },
  { title: 'Baking', description: 'Delicious baking recipes and techniques.' },
  { title: 'Investing', description: 'Investment strategies and market analysis.' },
  { title: 'Cryptocurrency', description: 'News and updates on cryptocurrencies.' },
  { title: 'Software Development', description: 'Programming tips and tutorials.' },
  { title: 'Artificial Intelligence', description: 'AI advancements and trends.' },
  { title: 'Blockchain', description: 'Blockchain technology and applications.' },
  { title: 'Cybersecurity', description: 'Staying safe in the digital world.' },
  { title: 'Cloud Computing', description: 'Cloud services and infrastructure.' },
  { title: 'Data Science', description: 'Big data analytics and tools.' },
  { title: 'Machine Learning', description: 'ML algorithms and case studies.' },
  { title: 'Biotech', description: 'Advances in biotechnology.' },
  { title: 'Energy', description: 'Renewable energy and power industry.' },
  { title: 'E-Commerce', description: 'Trends in the online shopping world.' },
  { title: 'Social Media', description: 'The latest trends in social platforms.' },
  { title: 'Content Creation', description: 'Tips for creators and influencers.' }
])

# Tạo bài viết cho từng danh mục
categories.each do |category|
  3.times do |i|  # Tạo 3 bài viết cho mỗi danh mục
    category.posts.create(
      title: "#{category.title} Post #{i + 1}",
      description: "This is the content for the #{category.title} post number #{i + 1}."
    )
  end
end
