_ = require 'underscore'
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = mongoose.Schema.Types.ObjectId;

ContentSchema = new Schema
  key: String
  markdown: Boolean
  content: String

mongoose.model 'Content', ContentSchema

UserSchema = new Schema
  twitter: String
  twitterData: Object
  admin: Boolean
  github: String

mongoose.model 'User', UserSchema

GroupSchema = new Schema
  name:
    type: String
    required: true
  description: String
  # location: mongoose.Schema.Geometry
  members: [{ type: ObjectId, ref: 'User' }]
  # logo: mongoose.Schema.File
  events: [{ type: ObjectId, ref: 'Event' }]

mongoose.model 'Group', GroupSchema

EventSchema = new Schema
  name:
    type: String
    required: true
  description: String
  speakers: [{ type: ObjectId, ref: 'User' }]
  organizer: { type: ObjectId, ref: 'Group' }

mongoose.model 'Event', EventSchema

ArticleSchema = new Schema
  title:
    type: String
    required: true
  author: { type: ObjectId, ref: 'Group' }
  content: String
  tags: [String]
  publication: Date
  comments: [
    title: String
    author: { type: ObjectId, ref: 'User' }
    publication: Date
  ]

mongoose.model 'Artilce', ArticleSchema